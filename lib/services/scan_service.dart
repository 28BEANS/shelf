import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ScanFailure implements Exception {
  const ScanFailure(this.code, this.message);
  final String code;
  final String message;
  @override
  String toString() => message;
}

class ScanCapabilities {
  const ScanCapabilities({
    required this.roomBackend,
    required this.itemCamera,
    required this.semanticStorage,
  });
  final String roomBackend;
  final bool itemCamera;
  final bool semanticStorage;
  bool get canScanRoom => roomBackend != 'unsupported';
}

class ShelfSurface {
  const ShelfSurface({
    required this.id,
    required this.kind,
    required this.width,
    required this.height,
    required this.transform,
  });
  final String id, kind;
  final double width, height;
  final List<double> transform;
  Map<String, Object?> toJson() => {
    'id': id,
    'kind': kind,
    'width': width,
    'height': height,
    'transform': transform,
  };
  factory ShelfSurface.fromMap(Map<dynamic, dynamic> map) => ShelfSurface(
    id: map['id'] as String,
    kind: map['kind'] as String,
    width: (map['width'] as num).toDouble(),
    height: (map['height'] as num).toDouble(),
    transform: (map['transform'] as List)
        .map((value) => (value as num).toDouble())
        .toList(),
  );
}

class ShelfStorageUnit {
  const ShelfStorageUnit({
    required this.id,
    required this.kind,
    required this.source,
    required this.width,
    required this.height,
    required this.depth,
    required this.transform,
    required this.confidence,
    this.name = '',
  });
  final String id, kind, source, name;
  final double width, height, depth, confidence;
  final List<double> transform;
  Map<String, Object?> toJson() => {
    'id': id,
    'kind': kind,
    'source': source,
    'width': width,
    'height': height,
    'depth': depth,
    'transform': transform,
    'confidence': confidence,
    'name': name,
  };
  factory ShelfStorageUnit.fromMap(Map<dynamic, dynamic> map) =>
      ShelfStorageUnit(
        id: map['id'] as String,
        kind: map['kind'] as String,
        source: map['source'] as String,
        name: map['name'] as String? ?? '',
        width: (map['width'] as num).toDouble(),
        height: (map['height'] as num).toDouble(),
        depth: (map['depth'] as num).toDouble(),
        confidence: (map['confidence'] as num).toDouble(),
        transform: (map['transform'] as List)
            .map((value) => (value as num).toDouble())
            .toList(),
      );
}

class ShelfRoom {
  const ShelfRoom({
    required this.backend,
    required this.surfaces,
    required this.storage,
  });
  final String backend;
  final List<ShelfSurface> surfaces;
  final List<ShelfStorageUnit> storage;
  Map<String, Object?> toJson() => {
    'backend': backend,
    'surfaces': surfaces.map((value) => value.toJson()).toList(),
    'storage': storage.map((value) => value.toJson()).toList(),
  };
  factory ShelfRoom.fromMap(Map<dynamic, dynamic> map) => ShelfRoom(
    backend: map['backend'] as String,
    surfaces: (map['surfaces'] as List)
        .map((value) => ShelfSurface.fromMap(value as Map))
        .toList(),
    storage: (map['storage'] as List)
        .map((value) => ShelfStorageUnit.fromMap(value as Map))
        .toList(),
  );
}

class ItemCaptureSuggestion {
  const ItemCaptureSuggestion({
    required this.name,
    required this.source,
    required this.confidence,
    this.identifier = '',
  });
  final String name, source, identifier;
  final double confidence;
  factory ItemCaptureSuggestion.fromMap(Map<dynamic, dynamic> map) =>
      ItemCaptureSuggestion(
        name: map['name'] as String,
        source: map['source'] as String,
        confidence: (map['confidence'] as num).toDouble(),
        identifier: map['identifier'] as String? ?? '',
      );
}

abstract interface class ScanService {
  Future<ScanCapabilities> capabilities();
  Future<ShelfRoom> scanRoom();
  Future<List<ItemCaptureSuggestion>> scanItems();
  Future<void> cancel();
}

class NativeScanService implements ScanService {
  const NativeScanService();
  static const _channel = MethodChannel('shelf/scanner');
  bool get _supportedPlatform => !kIsWeb && Platform.isIOS;

  Future<T> _invoke<T>(String method) async {
    if (!_supportedPlatform) {
      throw const ScanFailure(
        'unsupported',
        'Camera scanning is available only on supported iPhones. Set up manually here.',
      );
    }
    try {
      return await _channel.invokeMethod<T>(method) as T;
    } on PlatformException catch (error) {
      throw ScanFailure(error.code, error.message ?? 'Scanning failed.');
    }
  }

  @override
  Future<ScanCapabilities> capabilities() async {
    if (!_supportedPlatform) {
      return const ScanCapabilities(
        roomBackend: 'unsupported',
        itemCamera: false,
        semanticStorage: false,
      );
    }
    final map = await _invoke<Map<dynamic, dynamic>>('capabilities');
    return ScanCapabilities(
      roomBackend: map['roomBackend'] as String,
      itemCamera: map['itemCamera'] as bool,
      semanticStorage: map['semanticStorage'] as bool,
    );
  }

  @override
  Future<ShelfRoom> scanRoom() async =>
      ShelfRoom.fromMap(await _invoke<Map<dynamic, dynamic>>('startRoom'));

  @override
  Future<List<ItemCaptureSuggestion>> scanItems() async =>
      (await _invoke<List<dynamic>>(
        'startItems',
      )).map((value) => ItemCaptureSuggestion.fromMap(value as Map)).toList();

  @override
  Future<void> cancel() async {
    if (_supportedPlatform) await _invoke<Object?>('cancel');
  }
}
