import 'dart:convert';
import 'dart:io';

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
          depth: 0.1,
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
    expect(
      ShelfRoom.fromMap(
        jsonDecode(rows.single.geometryJson) as Map,
      ).surfaces.single.depth,
      0.1,
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

  test(
    'room photos, pins, and item photos survive rescan and reopen',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'shelf-visual-scan',
      );
      final file = File('${directory.path}/inventory.sqlite');
      var database = AppDatabase(NativeDatabase(file));
      var repository = InventoryRepository(database);
      final workspace = await repository.saveWorkspace('Media Room', '');
      const firstRoom = ShelfRoom(
        scanId: 'scan-one',
        backend: 'arkit',
        surfaces: [],
        storage: [],
        photoPaths: ['ShelfMedia/rooms/scan-one/view-1.jpg'],
        previewPath: 'ShelfMedia/rooms/scan-one/view-1.jpg',
        visualStatus: 'photo',
      );
      const container = ShelfContainer(
        id: 'cabinet-one',
        name: 'Cabinet',
        type: 'Cabinet',
        markerPhotoPath: 'ShelfMedia/rooms/scan-one/view-1.jpg',
        markerX: 0.3,
        markerY: 0.6,
      );
      await repository.saveScannedRoom(workspace, firstRoom, [container]);
      await repository.saveLayout(container, 'One section', ['Shelf 1']);
      var state = await repository.load();
      final sectionId = state.sections.single.id;
      await repository.addCandidate(
        sectionId: sectionId,
        name: 'Notebook',
        source: 'vision',
        photoPath: 'ShelfMedia/items/notebook.jpg',
      );
      final candidateId = (await repository.load()).candidates.single.id;
      await repository.updateCandidate(candidateId, state: 'accepted');
      await repository.confirmCandidates(sectionId, workspace);
      final itemId = (await repository.load()).items.single.id;

      const secondRoom = ShelfRoom(
        scanId: 'scan-two',
        backend: 'arkit',
        surfaces: [],
        storage: [],
        photoPaths: ['ShelfMedia/rooms/scan-two/view-1.jpg'],
        previewPath: 'ShelfMedia/rooms/scan-two/view-1.jpg',
        visualStatus: 'photo',
      );
      await repository.saveScannedRoom(workspace, secondRoom, [
        (await repository.load()).containers.single.copyWith(
          markerPhotoPath: 'ShelfMedia/rooms/scan-two/view-1.jpg',
          markerX: 0.7,
          markerY: 0.4,
        ),
      ]);
      await database.close();
      database = AppDatabase(NativeDatabase(file));
      repository = InventoryRepository(database);
      state = await repository.load();
      expect(state.visualScan?.id, 'scan-two');
      expect(state.visualScan?.visualStatus, 'photo');
      expect(state.containers.single.id, container.id);
      expect(state.containers.single.markerX, 0.7);
      expect(state.allSections.single.id, sectionId);
      expect(state.items.single.id, itemId);
      expect(state.items.single.photoPath, 'ShelfMedia/items/notebook.jpg');
      expect(await database.select(database.roomScans).get(), hasLength(2));
      await database.close();
      await directory.delete(recursive: true);
    },
  );

  test(
    'removing a view preserves pinned photos and updates the preview',
    () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = InventoryRepository(database);
      final workspace = await repository.saveWorkspace('Media Room', '');
      const first = 'ShelfMedia/rooms/demo/view-1.jpg';
      const second = 'ShelfMedia/rooms/demo/view-2.jpg';
      const room = ShelfRoom(
        scanId: 'demo',
        backend: 'arkit',
        surfaces: [],
        storage: [],
        photoPaths: [first, second],
        previewPath: first,
        visualStatus: 'photo',
      );
      await repository.saveScannedRoom(workspace, room, [
        const ShelfContainer(
          id: 'cabinet',
          name: 'Cabinet',
          type: 'Cabinet',
          markerPhotoPath: second,
        ),
      ]);

      await expectLater(
        repository.removeRoomPhoto('demo', second),
        throwsStateError,
      );
      await repository.removeRoomPhoto('demo', first);
      final state = await repository.load();
      expect(state.visualScan?.photoPaths, [second]);
      expect(state.visualScan?.previewPath, second);
      expect(state.containers.single.markerPhotoPath, second);
      final saved = (await database.select(database.roomScans).get()).single;
      expect(jsonDecode(saved.geometryJson)['photoPaths'], [second]);
      await database.close();
    },
  );
}
