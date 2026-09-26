import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:final_project/data/app_database.dart';
import 'package:final_project/data/inventory_repository.dart';
import 'package:final_project/models/shelf_models.dart';

void main() {
  test(
    'confirmed inventory keeps its sections and movement after reopen',
    () async {
      final directory = await Directory.systemTemp.createTemp('shelf-week-two');
      final file = File('${directory.path}/inventory.sqlite');
      var database = AppDatabase(NativeDatabase(file));
      var repository = InventoryRepository(database);

      final workspaceId = await repository.saveWorkspace(
        'Campus Media Room',
        'Equipment',
      );
      const container = ShelfContainer(
        id: 'cabinet-1',
        name: 'Equipment Cabinet',
        type: 'Cabinet',
      );
      await repository.saveContainer(container, workspaceId);
      await repository.saveLayout(container, 'Three sections', [
        'Top Shelf',
        'Middle Shelf',
        'Bottom Shelf',
      ]);
      var state = await repository.load(selectedContainerId: container.id);
      final top = state.sections[0].id;
      final middle = state.sections[1].id;

      await repository.addCandidate(
        sectionId: top,
        name: 'Sony Camera Lens',
        category: 'Camera lens',
        identifier: 'SEL2470GM2',
      );
      await repository.addCandidate(
        sectionId: top,
        name: 'Uncertain adapter',
        source: 'browser_sample',
      );
      expect(await repository.confirmCandidates(top, workspaceId), 1);
      expect(await repository.confirmCandidates(top, workspaceId), 0);

      state = await repository.load(selectedContainerId: container.id);
      expect(state.items, hasLength(1));
      expect(state.items.single.homeSectionId, top);
      expect(state.items.single.currentSectionId, top);
      expect(
        state.candidates.where((candidate) => candidate.state == 'pending'),
        hasLength(1),
      );

      await repository.moveItem(state.items.single.id, middle);
      await repository.saveLayout(container, 'Three sections', [
        'Top Shelf',
        'Middle Shelf',
        'Bottom Shelf',
      ]);
      await expectLater(
        repository.saveLayout(container, 'One section', ['Only Section']),
        throwsStateError,
      );
      await database.close();

      database = AppDatabase(NativeDatabase(file));
      repository = InventoryRepository(database);
      state = await repository.load(selectedContainerId: container.id);
      expect(state.workspace?.name, 'Campus Media Room');
      expect(
        state.sections.map((section) => section.id),
        containsAll([top, middle]),
      );
      expect(state.items.single.homeSectionId, top);
      expect(state.items.single.currentSectionId, middle);
      expect(
        await database.select(database.movementRecords).get(),
        hasLength(1),
      );
      final itemId = state.items.single.id;
      await repository.checkoutItem(
        itemId,
        'Vince',
        DateTime.now().add(const Duration(days: 3)),
        'Good',
        'Kit',
      );
      await expectLater(
        repository.checkoutItem(
          itemId,
          'Another',
          DateTime.now().add(const Duration(days: 2)),
          'Good',
          '',
        ),
        throwsStateError,
      );
      await database.close();
      database = AppDatabase(NativeDatabase(file));
      repository = InventoryRepository(database);
      state = await repository.load(selectedContainerId: container.id);
      expect(state.items.single.status, ItemStatus.checkedOut);
      expect(state.loans.single.borrower, 'Vince');
      expect(state.loans.single.returnedAt, isNull);
      await repository.returnItem(itemId);
      await expectLater(repository.returnItem(itemId), throwsStateError);
      state = await repository.load(selectedContainerId: container.id);
      expect(state.items.single.status, ItemStatus.available);
      expect(state.items.single.homeSectionId, top);
      expect(state.items.single.currentSectionId, middle);
      expect(state.loans.single.returnedAt, isNotNull);
      await database.close();
      await directory.delete(recursive: true);
    },
  );
}
