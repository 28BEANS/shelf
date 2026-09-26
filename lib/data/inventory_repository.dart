import 'package:drift/drift.dart';

import '../models/shelf_models.dart';
import '../state/setup_state.dart';
import 'app_database.dart' hide ScanCandidate;

class InventoryRepository {
  InventoryRepository(this.db);
  final AppDatabase db;
  static int _sequence = 0;
  static String nextId(String prefix) =>
      '$prefix-${DateTime.now().microsecondsSinceEpoch}-${_sequence++}';

  Future<SetupState> load({String? selectedContainerId}) async {
    final workspaces = await db.select(db.workspaces).get();
    final workspace = workspaces.isEmpty ? null : workspaces.first;
    if (workspace == null) return const SetupState(loading: false);
    final containerRows = await (db.select(
      db.storageContainers,
    )..where((row) => row.workspaceId.equals(workspace.id))).get();
    final sectionRows = await db.select(db.storageSections).get();
    final itemRows = await (db.select(
      db.inventoryItems,
    )..where((row) => row.workspaceId.equals(workspace.id))).get();
    final candidateRows = await db.select(db.scanCandidates).get();
    final loanRows = await db.select(db.checkoutRecords).get();
    final moveRows = await db.select(db.movementRecords).get();
    final containers = [
      for (final row in containerRows)
        ShelfContainer(
          id: row.id,
          workspaceId: row.workspaceId,
          name: row.name,
          type: row.type,
          layoutLabel: row.layoutLabel,
          fromSampleScan: row.fromSampleScan,
        ),
    ];
    final allSections = [
      for (final row in sectionRows)
        ShelfSection(
          id: row.id,
          containerId: row.containerId,
          name: row.name,
          order: row.sortOrder,
        ),
    ];
    final selected = containers.where((c) => c.id == selectedContainerId);
    final container = selected.isNotEmpty
        ? selected.first
        : (containers.isEmpty ? null : containers.last);
    final sections = [
      for (final section in allSections)
        if (section.containerId == container?.id) section,
    ]..sort((a, b) => a.order.compareTo(b.order));
    return SetupState(
      loading: false,
      workspace: WorkspaceDraft(
        id: workspace.id,
        name: workspace.name,
        description: workspace.description,
      ),
      container: container,
      containers: containers,
      sections: sections,
      allSections: allSections,
      items: [
        for (final row in itemRows)
          ShelfItem(
            id: row.id,
            name: row.name,
            category: row.category,
            model: row.model,
            identifier: row.identifier,
            status: switch (row.status) {
              'checkedOut' => ItemStatus.checkedOut,
              'needsReview' => ItemStatus.needsReview,
              _ => ItemStatus.available,
            },
            homeSectionId: row.homeSectionId,
            currentSectionId: row.currentSectionId,
            lastConfirmedAt: row.lastConfirmedAt,
          ),
      ],
      candidates: [
        for (final row in candidateRows)
          ScanCandidate(
            id: row.id,
            sectionId: row.sectionId,
            name: row.name,
            category: row.category,
            model: row.model,
            identifier: row.identifier,
            confidence: row.confidence,
            state: row.state,
            source: row.source,
            accepted: row.state == 'accepted' || row.state == 'confirmed',
          ),
      ],
      loans: [
        for (final row in loanRows)
          ShelfLoan(
            id: row.id,
            itemId: row.itemId,
            borrower: row.borrower,
            dueAt: row.dueAt,
            checkedOutAt: row.checkedOutAt,
            returnedAt: row.returnedAt,
            condition: row.condition,
            notes: row.notes,
          ),
      ],
      moves: [
        for (final row in moveRows)
          ShelfMove(
            itemId: row.itemId,
            fromSectionId: row.fromSectionId,
            toSectionId: row.toSectionId,
            movedAt: row.movedAt,
          ),
      ],
      layoutLabel: container?.layoutLabel,
    );
  }

  Future<String> saveWorkspace(String name, String description) async {
    final existing = await db.select(db.workspaces).get();
    final id = existing.isEmpty ? nextId('workspace') : existing.first.id;
    await db
        .into(db.workspaces)
        .insertOnConflictUpdate(
          WorkspacesCompanion.insert(
            id: id,
            name: name.trim(),
            description: Value(description.trim()),
          ),
        );
    return id;
  }

  Future<void> saveContainer(
    ShelfContainer container,
    String workspaceId,
  ) async {
    await db
        .into(db.storageContainers)
        .insertOnConflictUpdate(
          StorageContainersCompanion.insert(
            id: container.id,
            workspaceId: workspaceId,
            name: container.name.trim(),
            type: container.type,
            layoutLabel: Value(container.layoutLabel),
            fromSampleScan: Value(container.fromSampleScan),
          ),
        );
  }

  Future<void> recordSampleRoomScan(
    String workspaceId,
    String containerId,
  ) async {
    final scanId = nextId('scan');
    await db
        .into(db.roomScans)
        .insert(
          RoomScansCompanion.insert(
            id: scanId,
            workspaceId: workspaceId,
            source: 'browser_sample',
          ),
        );
    await (db.update(db.storageContainers)
          ..where((row) => row.id.equals(containerId)))
        .write(StorageContainersCompanion(roomScanId: Value(scanId)));
  }

  Future<void> saveLayout(
    ShelfContainer container,
    String label,
    List<String> names,
  ) async {
    await db.transaction(() async {
      final old = await (db.select(
        db.storageSections,
      )..where((row) => row.containerId.equals(container.id))).get();
      old.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      if (names.length < old.length) {
        for (final section in old.skip(names.length)) {
          final assigned =
              await (db.select(db.inventoryItems)..where(
                    (row) =>
                        row.homeSectionId.equals(section.id) |
                        row.currentSectionId.equals(section.id),
                  ))
                  .get();
          if (assigned.isNotEmpty) {
            throw StateError(
              'Move items out of sections before removing them.',
            );
          }
          final movements =
              await (db.select(db.movementRecords)..where(
                    (row) =>
                        row.fromSectionId.equals(section.id) |
                        row.toSectionId.equals(section.id),
                  ))
                  .get();
          if (movements.isNotEmpty) {
            throw StateError('This section is part of item movement history.');
          }
          await (db.delete(
            db.scanCandidates,
          )..where((row) => row.sectionId.equals(section.id))).go();
          await (db.delete(
            db.storageSections,
          )..where((row) => row.id.equals(section.id))).go();
        }
      }
      for (var i = 0; i < names.length; i++) {
        final id = i < old.length ? old[i].id : nextId('section');
        await db
            .into(db.storageSections)
            .insertOnConflictUpdate(
              StorageSectionsCompanion.insert(
                id: id,
                containerId: container.id,
                name: names[i],
                sortOrder: i,
              ),
            );
      }
      await (db.update(db.storageContainers)
            ..where((row) => row.id.equals(container.id)))
          .write(StorageContainersCompanion(layoutLabel: Value(label)));
    });
  }

  Future<void> renameSection(String id, String name) =>
      (db.update(db.storageSections)..where((row) => row.id.equals(id))).write(
        StorageSectionsCompanion(name: Value(name.trim())),
      );

  Future<void> removeContainer(String id) async {
    await db.transaction(() async {
      final sections = await (db.select(
        db.storageSections,
      )..where((row) => row.containerId.equals(id))).get();
      for (final section in sections) {
        final assigned =
            await (db.select(db.inventoryItems)..where(
                  (row) =>
                      row.homeSectionId.equals(section.id) |
                      row.currentSectionId.equals(section.id),
                ))
                .get();
        if (assigned.isNotEmpty) {
          throw StateError('Move items before removing this container.');
        }
        final movements =
            await (db.select(db.movementRecords)..where(
                  (row) =>
                      row.fromSectionId.equals(section.id) |
                      row.toSectionId.equals(section.id),
                ))
                .get();
        if (movements.isNotEmpty) {
          throw StateError('This container is part of item movement history.');
        }
        await (db.delete(
          db.scanCandidates,
        )..where((row) => row.sectionId.equals(section.id))).go();
      }
      await (db.delete(
        db.storageSections,
      )..where((row) => row.containerId.equals(id))).go();
      await (db.delete(
        db.storageContainers,
      )..where((row) => row.id.equals(id))).go();
    });
  }

  Future<void> addSampleCandidates(
    String sectionId,
    List<ScanCandidate> suggestions,
  ) async {
    final existing =
        await (db.select(db.scanCandidates)..where(
              (row) =>
                  row.sectionId.equals(sectionId) &
                  row.source.equals('browser_sample'),
            ))
            .get();
    if (existing.isNotEmpty) return;
    for (final suggestion in suggestions) {
      await addCandidate(
        sectionId: sectionId,
        name: suggestion.name,
        category: suggestion.name.contains('Battery') ? 'Battery' : 'Equipment',
        confidence: suggestion.confidence,
        source: 'browser_sample',
      );
    }
  }

  Future<void> addCandidate({
    required String sectionId,
    required String name,
    String category = 'Equipment',
    String model = '',
    String identifier = '',
    double confidence = 1,
    String source = 'manual',
  }) async {
    await db
        .into(db.scanCandidates)
        .insert(
          ScanCandidatesCompanion.insert(
            id: nextId('candidate'),
            sectionId: sectionId,
            name: name.trim(),
            category: Value(category.trim()),
            model: Value(model.trim()),
            identifier: Value(identifier.trim()),
            confidence: Value(confidence),
            source: Value(source),
            state: Value(source == 'manual' ? 'accepted' : 'pending'),
          ),
        );
  }

  Future<void> updateCandidate(
    String id, {
    String? name,
    String? category,
    String? model,
    String? identifier,
    String? state,
  }) => (db.update(db.scanCandidates)..where((row) => row.id.equals(id))).write(
    ScanCandidatesCompanion(
      name: name == null ? const Value.absent() : Value(name.trim()),
      category: category == null
          ? const Value.absent()
          : Value(category.trim()),
      model: model == null ? const Value.absent() : Value(model.trim()),
      identifier: identifier == null
          ? const Value.absent()
          : Value(identifier.trim()),
      state: state == null ? const Value.absent() : Value(state),
    ),
  );

  Future<int> confirmCandidates(String sectionId, String workspaceId) =>
      db.transaction(() async {
        final candidates =
            await (db.select(db.scanCandidates)..where(
                  (row) =>
                      row.sectionId.equals(sectionId) &
                      row.state.equals('accepted'),
                ))
                .get();
        var saved = 0;
        for (final candidate in candidates) {
          final existing =
              await (db.select(
                    db.inventoryItems,
                  )..where((row) => row.sourceCandidateId.equals(candidate.id)))
                  .getSingleOrNull();
          if (existing == null) {
            await db
                .into(db.inventoryItems)
                .insert(
                  InventoryItemsCompanion.insert(
                    id: nextId('item'),
                    workspaceId: workspaceId,
                    name: candidate.name,
                    category: Value(candidate.category),
                    model: Value(candidate.model),
                    identifier: Value(candidate.identifier),
                    homeSectionId: sectionId,
                    currentSectionId: sectionId,
                    sourceCandidateId: Value(candidate.id),
                    lastConfirmedAt: Value(DateTime.now()),
                  ),
                );
            saved++;
          }
          await updateCandidate(candidate.id, state: 'confirmed');
        }
        return saved;
      });

  Future<void> moveItem(String itemId, String destinationSectionId) =>
      db.transaction(() async {
        final item = await (db.select(
          db.inventoryItems,
        )..where((row) => row.id.equals(itemId))).getSingle();
        if (item.currentSectionId == destinationSectionId) return;
        final destination =
            await (db.select(db.storageSections)
                  ..where((row) => row.id.equals(destinationSectionId)))
                .getSingleOrNull();
        if (destination == null) throw StateError('Choose a valid section.');
        await (db.update(
          db.inventoryItems,
        )..where((row) => row.id.equals(itemId))).write(
          InventoryItemsCompanion(
            currentSectionId: Value(destinationSectionId),
            lastConfirmedAt: Value(DateTime.now()),
          ),
        );
        await db
            .into(db.movementRecords)
            .insert(
              MovementRecordsCompanion.insert(
                id: nextId('move'),
                itemId: itemId,
                fromSectionId: item.currentSectionId,
                toSectionId: destinationSectionId,
              ),
            );
      });

  Future<void> checkoutItem(
    String itemId,
    String borrower,
    DateTime dueAt,
    String condition,
    String notes,
  ) => db.transaction(() async {
    if (borrower.trim().isEmpty) throw StateError('Enter a borrower.');
    if (!dueAt.isAfter(DateTime.now())) {
      throw StateError('Choose a future return date.');
    }
    final item = await (db.select(
      db.inventoryItems,
    )..where((r) => r.id.equals(itemId))).getSingle();
    if (item.status == 'checkedOut') {
      throw StateError('This item is already checked out.');
    }
    final active = await (db.select(
      db.checkoutRecords,
    )..where((r) => r.itemId.equals(itemId) & r.returnedAt.isNull())).get();
    if (active.isNotEmpty) {
      throw StateError('This item already has an active loan.');
    }
    await db
        .into(db.checkoutRecords)
        .insert(
          CheckoutRecordsCompanion.insert(
            id: nextId('loan'),
            itemId: itemId,
            borrower: borrower.trim(),
            dueAt: dueAt,
            checkedOutAt: Value(DateTime.now()),
            condition: Value(condition),
            notes: Value(notes.trim()),
          ),
        );
    await (db.update(db.inventoryItems)..where((r) => r.id.equals(itemId)))
        .write(const InventoryItemsCompanion(status: Value('checkedOut')));
  });

  Future<void> returnItem(String itemId) => db.transaction(() async {
    final active = await (db.select(
      db.checkoutRecords,
    )..where((r) => r.itemId.equals(itemId) & r.returnedAt.isNull())).get();
    if (active.length != 1) throw StateError('This item has no active loan.');
    await (db.update(db.checkoutRecords)
          ..where((r) => r.id.equals(active.single.id)))
        .write(CheckoutRecordsCompanion(returnedAt: Value(DateTime.now())));
    await (db.update(
      db.inventoryItems,
    )..where((r) => r.id.equals(itemId))).write(
      InventoryItemsCompanion(
        status: const Value('available'),
        lastConfirmedAt: Value(DateTime.now()),
      ),
    );
  });
}
