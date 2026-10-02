import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/shelf_auth.dart';
import '../theme.dart';
import '../widgets/hard_shadow_card.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/shelf_brand.dart';
import '../widgets/shelf_illustration.dart';
import '../widgets/shelf_loading_animation.dart';
import 'shell_screen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key, this.authGateway});

  final ShelfAuthGateway? authGateway;

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  late final ShelfAuthGateway? _auth =
      widget.authGateway ??
      (const String.fromEnvironment('SUPABASE_URL').isNotEmpty &&
              const String.fromEnvironment(
                'SUPABASE_PUBLISHABLE_KEY',
              ).isNotEmpty
          ? SupabaseShelfAuth(Supabase.instance.client)
          : null);
  final _pin = TextEditingController();
  final _confirm = TextEditingController();
  ShelfAuthStep? _step;
  bool _busy = false;
  bool _unlocked = false;
  bool _startupComplete = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final minimumDisplay = Future<void>.delayed(
      const Duration(milliseconds: 2200),
    );
    ShelfAuthStep? step;
    String? error;
    try {
      step = await _auth?.initialStep();
    } catch (_) {
      error = 'Could not load your account. Try reopening Shelf.';
    }
    await minimumDisplay;
    if (mounted) {
      setState(() {
        _step = step;
        _error = error;
        _startupComplete = true;
      });
    }
  }

  @override
  void dispose() {
    _pin.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } catch (error) {
      if (mounted) {
        setState(
          () => _error = error is AuthException
              ? error.message
              : error is StateError
              ? error.message
              : 'That did not work. Please try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _register() => _run(() async {
    final step = await _auth!.continueWithGoogle();
    if (mounted) {
      setState(() {
        _step = step;
        _pin.clear();
        _confirm.clear();
      });
    }
  });

  void _savePasscode() => _run(() async {
    if (!RegExp(r'^\d{6}$').hasMatch(_pin.text)) {
      throw StateError('Enter exactly six digits.');
    }
    if (_pin.text != _confirm.text) {
      throw StateError('Passcodes do not match. Try again.');
    }
    await _auth!.createPasscode(_pin.text);
    if (mounted) {
      setState(() {
        _step = ShelfAuthStep.login;
        _pin.clear();
        _confirm.clear();
      });
    }
  });

  void _login() => _run(() async {
    if (!RegExp(r'^\d{6}$').hasMatch(_pin.text)) {
      throw StateError('Enter exactly six digits.');
    }
    if (!await _auth!.unlock(_pin.text)) {
      throw StateError('Incorrect passcode. Try again.');
    }
    if (mounted) {
      setState(() {
        _pin.clear();
        _unlocked = true;
      });
    }
  });

  void _logout() => _run(() async {
    await _auth!.logout();
    if (mounted) {
      setState(() {
        _unlocked = false;
        _pin.clear();
        _step = ShelfAuthStep.login;
      });
    }
  });

  @override
  Widget build(BuildContext context) {
    if (!_startupComplete) {
      return const Scaffold(
        body: ShelfMobileRail(
          child: SafeArea(
            child: Center(
              child: ShelfLoadingAnimation(label: 'OPENING YOUR SHELF'),
            ),
          ),
        ),
      );
    }
    if (_unlocked) return ShelfShell(onLogout: _logout);
    return Scaffold(
      body: ShelfMobileRail(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const Row(
                children: [
                  ShelfLogoMark(compact: true),
                  SizedBox(width: AppSpacing.listItem),
                  Expanded(
                    child: Text(
                      'SHELF',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  ShelfLocatorRail(),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              HardShadowCard(
                color: Theme.of(context).colorScheme.secondary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR SPACE, REMEMBERED.',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Know where\neverything belongs.',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Text(
                      'Scan a workspace, confirm what Shelf finds, and retrieve anything in seconds.',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const ShelfIllustration(height: 150),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.listItem),
              HardShadowCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(_description),
                    const SizedBox(height: AppSpacing.md),
                    if (_step == ShelfAuthStep.createPasscode ||
                        _step == ShelfAuthStep.login) ...[
                      _pinField(
                        _pin,
                        'Six-digit passcode',
                        const Key('passcode'),
                      ),
                      if (_step == ShelfAuthStep.createPasscode) ...[
                        const SizedBox(height: AppSpacing.listItem),
                        _pinField(
                          _confirm,
                          'Confirm passcode',
                          const Key('confirm-passcode'),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.md),
                    ],
                    if (_error != null) ...[
                      Text(
                        _error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                    if (_busy) ...[
                      const LinearProgressIndicator(),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        _step == ShelfAuthStep.register
                            ? 'Finish Google sign-in in your browser, then return to Shelf.'
                            : 'Checking your passcode…',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                    PrimaryActionButton(
                      key: const Key('enter-shelf'),
                      label: _buttonLabel,
                      onPressed: _busy || _step == null || _auth == null
                          ? null
                          : _step == ShelfAuthStep.register
                          ? _register
                          : _step == ShelfAuthStep.createPasscode
                          ? _savePasscode
                          : _login,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pinField(TextEditingController controller, String label, Key key) =>
      TextField(
        key: key,
        controller: controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        obscureText: true,
        maxLength: 6,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(labelText: label, counterText: ''),
      );

  String get _title => switch (_step) {
    ShelfAuthStep.register => 'Create your account',
    ShelfAuthStep.createPasscode => 'Secure this device',
    ShelfAuthStep.login => 'Welcome back',
    null => _auth == null ? 'Account setup needed' : 'Opening Shelf',
  };

  String get _description => switch (_step) {
    ShelfAuthStep.register =>
      'Continue with Google to create or reconnect your Shelf account.',
    ShelfAuthStep.createPasscode =>
      'Choose a six-digit passcode. You will use it to open Shelf on this device.',
    ShelfAuthStep.login =>
      'Enter your six-digit passcode to open your saved spaces.',
    null =>
      _auth == null
          ? 'This build needs a Supabase project URL and publishable key.'
          : 'Checking your account…',
  };

  String get _buttonLabel => switch (_step) {
    ShelfAuthStep.register => 'CONTINUE WITH GOOGLE',
    ShelfAuthStep.createPasscode => 'SAVE PASSCODE',
    ShelfAuthStep.login => 'OPEN SHELF',
    null => 'PLEASE WAIT',
  };
}
