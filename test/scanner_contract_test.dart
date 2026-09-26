import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:final_project/data/app_database.dart';
import 'package:final_project/data/inventory_repository.dart';
import 'package:final_project/models/shelf_models.dart';
import 'package:final_project/services/scan_service.dart';

void main() {
  test('a reviewed room stores only confirmed storage with geometry', () async {
    final database = AppDatabase(NativeDatabase.memory());
    final repository = InventoryRepository(database);
    final workspace = await repository.saveWorkspace('Media Room', '');
    const transform = <double>[1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 2, 1, 3, 1];
    const room = ShelfRoom(
      backend: 'arkit',
      surfaces: [
        ShelfSurface(
          id: 'wall-1',
          kind: 'wall',
          width: 3,
          height: 2.5,
          transform: transform,
        ),
      ],
      storage: [
        ShelfStorageUnit(
          id: 'ar-1',
          kind: 'Unknown',
          source: 'manual_ar',
          width: 0,
          height: 0,
          depth: 0,
          transform: transform,
          confidence: 1,
        ),
        ShelfStorageUnit(
          id: 'ar-2',
          kind: 'Unknown',
          source: 'manual_ar',
          width: 0,
          height: 0,
          depth: 0,
          transform: transform,
          confidence: 1,
        ),
      ],
    );
    await repository.saveScannedRoom(workspace, room, [
      ShelfContainer(
        id: 'logical-1',
        name: 'West cabinet',
        type: 'Cabinet',
        geometryJson: jsonEncode(room.storage.first.toJson()),
      ),
    ]);
    final state = await repository.load();
    expect(state.containers, hasLength(1));
    expect(state.containers.single.id, 'logical-1');
    expect(state.containers.single.geometryJson, contains('manual_ar'));
    final rows = await database.select(database.roomScans).get();
    expect(rows, hasLength(1));
    expect(rows.single.source, 'arkit');
    expect(
      ShelfRoom.fromMap(
        jsonDecode(rows.single.geometryJson) as Map,
      ).surfaces.single.kind,
      'wall',
    );
    await database.close();
  });

  test(
    'capabilities do not equate manual capture with semantic recognition',
    () {
      const capabilities = ScanCapabilities(
        roomBackend: 'arkit',
        itemCamera: true,
        semanticStorage: false,
      );
      expect(capabilities.canScanRoom, isTrue);
      expect(capabilities.semanticStorage, isFalse);
    },
  );
}
