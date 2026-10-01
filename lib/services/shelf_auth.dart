import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum ShelfAuthStep { register, createPasscode, login }

abstract class ShelfAuthGateway {
  Future<ShelfAuthStep> initialStep();
  Future<ShelfAuthStep> continueWithGoogle();
  Future<void> createPasscode(String passcode);
  Future<bool> unlock(String passcode);
  Future<void> logout();
}

/// Stores the Supabase refresh session in Keychain/Keystore, not preferences.
class ShelfSessionStorage extends LocalStorage {
  const ShelfSessionStorage();
  static const _storage = FlutterSecureStorage();
  static const _key = 'shelf.supabase.session';

  @override
  Future<void> initialize() async {}
  @override
  Future<bool> hasAccessToken() async => (await accessToken()) != null;
  @override
  Future<String?> accessToken() => _storage.read(key: _key);
  @override
  Future<void> persistSession(String value) =>
      _storage.write(key: _key, value: value);
  @override
  Future<void> removePersistedSession() => _storage.delete(key: _key);
}

class SupabaseShelfAuth implements ShelfAuthGateway {
  SupabaseShelfAuth(this._client, {FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final SupabaseClient _client;
  final FlutterSecureStorage _storage;
  static const _userKey = 'shelf.account.user_id';
  static const _pinKey = 'shelf.account.pin_verifier';
  static const _attemptKey = 'shelf.account.pin_failures';
  static const _cooldownKey = 'shelf.account.pin_cooldown_until';
  static final _pbkdf2 = Pbkdf2.hmacSha256(iterations: 210000, bits: 256);

  @override
  Future<ShelfAuthStep> initialStep() async {
    final boundId = await _storage.read(key: _userKey);
    final currentId = _client.auth.currentUser?.id;
    final hasSession = _client.auth.currentSession != null;
    if (boundId == null && currentId != null && hasSession) {
      return ShelfAuthStep.createPasscode;
    }
    if (boundId == null) return ShelfAuthStep.register;
    if (boundId == currentId &&
        hasSession &&
        await _storage.read(key: _pinKey) == null) {
      return ShelfAuthStep.createPasscode;
    }
    if (currentId != boundId || !hasSession) {
      // A PIN alone cannot restore a revoked or missing server session.
      return ShelfAuthStep.register;
    }
    return ShelfAuthStep.login;
  }

  @override
  Future<ShelfAuthStep> continueWithGoogle() async {
    final signedIn = Completer<void>();
    final subscription = _client.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedIn &&
          event.session?.user.id != null &&
          !signedIn.isCompleted) {
        signedIn.complete();
      }
    });
    try {
      final started = await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb
            ? null
            : 'app.shelf.inventory.visual://login-callback/',
        authScreenLaunchMode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
      );
      if (!started) throw StateError('Google sign-in could not open.');
      if (kIsWeb) return ShelfAuthStep.register;
      await signedIn.future.timeout(const Duration(minutes: 2));
    } on TimeoutException {
      throw StateError(
        'Google sign-in did not finish. Tap Continue with Google to try again.',
      );
    } finally {
      await subscription.cancel();
    }
    final userId = _client.auth.currentUser?.id;
    if (userId == null || _client.auth.currentSession == null) {
      throw StateError('Google account could not be verified.');
    }
    final boundId = await _storage.read(key: _userKey);
    if (boundId != null && boundId != userId) {
      await _client.auth.signOut();
      throw StateError(
        'This device is linked to another Shelf Google account.',
      );
    }
    if (boundId == userId && await _storage.read(key: _pinKey) != null) {
      return ShelfAuthStep.login;
    }
    return ShelfAuthStep.createPasscode;
  }

  @override
  Future<void> createPasscode(String passcode) async {
    _requireSixDigits(passcode);
    final userId = _client.auth.currentUser?.id;
    if (userId == null || _client.auth.currentSession == null) {
      throw StateError('Continue with Google before creating a passcode.');
    }
    final existing = await _storage.read(key: _userKey);
    if (existing != null && existing != userId) {
      throw StateError(
        'This device is linked to another Shelf Google account.',
      );
    }
    final random = Random.secure();
    final salt = List<int>.generate(32, (_) => random.nextInt(256));
    final hash = await _hash(passcode, salt);
    await _storage.write(
      key: _pinKey,
      value: '${base64Encode(salt)}:${base64Encode(hash)}',
    );
    await _storage.write(key: _userKey, value: userId);
    await _storage.delete(key: _attemptKey);
    await _storage.delete(key: _cooldownKey);
  }

  @override
  Future<bool> unlock(String passcode) async {
    _requireSixDigits(passcode);
    if (await initialStep() != ShelfAuthStep.login) return false;
    final until = int.tryParse(await _storage.read(key: _cooldownKey) ?? '');
    if (until != null && DateTime.now().millisecondsSinceEpoch < until) {
      throw StateError('Too many attempts. Try again in one minute.');
    }
    final verifier = await _storage.read(key: _pinKey);
    final parts = verifier?.split(':');
    if (parts == null || parts.length != 2) return false;
    final expected = base64Decode(parts[1]);
    final actual = await _hash(passcode, base64Decode(parts[0]));
    var difference = expected.length ^ actual.length;
    for (var i = 0; i < min(expected.length, actual.length); i++) {
      difference |= expected[i] ^ actual[i];
    }
    if (difference == 0) {
      await _storage.delete(key: _attemptKey);
      await _storage.delete(key: _cooldownKey);
      return true;
    }
    final attempts =
        (int.tryParse(await _storage.read(key: _attemptKey) ?? '') ?? 0) + 1;
    if (attempts >= 5) {
      await _storage.write(
        key: _cooldownKey,
        value:
            '${DateTime.now().add(const Duration(minutes: 1)).millisecondsSinceEpoch}',
      );
      await _storage.delete(key: _attemptKey);
    } else {
      await _storage.write(key: _attemptKey, value: '$attempts');
    }
    return false;
  }

  /// Lock this device and keep the Google-backed session for PIN-only return.
  @override
  Future<void> logout() async {}

  Future<List<int>> _hash(String passcode, List<int> salt) async =>
      (await _pbkdf2.deriveKeyFromPassword(
        password: passcode,
        nonce: salt,
      )).extractBytes();

  void _requireSixDigits(String passcode) {
    if (!RegExp(r'^\d{6}$').hasMatch(passcode)) {
      throw ArgumentError('Enter exactly six digits.');
    }
  }
}
