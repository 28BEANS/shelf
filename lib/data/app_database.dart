import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// Retained so existing week-one databases migrate without losing the spike record.
class PersistenceSpikeItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get status => text().withDefault(const Constant('available'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Workspaces extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class RoomScans extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text().references(Workspaces, #id)();
  TextColumn get source => text()();
  TextColumn get geometryJson => text().withDefault(const Constant('{}'))();
  DateTimeColumn get capturedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class StorageContainers extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text().references(Workspaces, #id)();
  TextColumn get roomScanId => text().nullable().references(RoomScans, #id)();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get layoutLabel => text().nullable()();
  TextColumn get geometryJson => text().nullable()();
  BoolColumn get fromSampleScan =>
      boolean().withDefault(const Constant(false))();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class StorageSections extends Table {
  TextColumn get id => text()();
  TextColumn get containerId => text().references(StorageContainers, #id)();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer()();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class InventoryItems extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text().references(Workspaces, #id)();
  TextColumn get name => text()();
  TextColumn get category => text().withDefault(const Constant('Equipment'))();
  TextColumn get model => text().withDefault(const Constant(''))();
  TextColumn get identifier => text().withDefault(const Constant(''))();
  TextColumn get status => text().withDefault(const Constant('available'))();
  TextColumn get homeSectionId => text().references(StorageSections, #id)();
  TextColumn get currentSectionId => text().references(StorageSections, #id)();
  TextColumn get sourceCandidateId => text().nullable()();
  DateTimeColumn get lastConfirmedAt =>
      dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CheckoutRecords extends Table {
  TextColumn get id => text()();
  TextColumn get itemId => text().references(InventoryItems, #id)();
  TextColumn get borrower => text()();
  DateTimeColumn get dueAt => dateTime()();
  DateTimeColumn get checkedOutAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get returnedAt => dateTime().nullable()();
  TextColumn get condition => text().withDefault(const Constant('Good'))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ScanCandidates extends Table {
  TextColumn get id => text()();
  TextColumn get sectionId => text().references(StorageSections, #id)();
  TextColumn get name => text()();
  TextColumn get category => text().withDefault(const Constant('Equipment'))();
  TextColumn get model => text().withDefault(const Constant(''))();
  TextColumn get identifier => text().withDefault(const Constant(''))();
  RealColumn get confidence => real().withDefault(const Constant(1.0))();
  TextColumn get state => text().withDefault(const Constant('pending'))();
  TextColumn get source => text().withDefault(const Constant('manual'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

class MovementRecords extends Table {
  TextColumn get id => text()();
  TextColumn get itemId => text().references(InventoryItems, #id)();
  TextColumn get fromSectionId => text().references(StorageSections, #id)();
  TextColumn get toSectionId => text().references(StorageSections, #id)();
  DateTimeColumn get movedAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    PersistenceSpikeItems,
    Workspaces,
    RoomScans,
    StorageContainers,
    StorageSections,
    InventoryItems,
    CheckoutRecords,
    ScanCandidates,
    MovementRecords,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor, String name = 'shelf'])
    : super(
        executor ??
            driftDatabase(
              name: name,
              web: DriftWebOptions(
                sqlite3Wasm: Uri.parse('sqlite3.wasm'),
                driftWorker: Uri.parse('drift_worker.js'),
              ),
            ),
      );

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(workspaces);
        await m.createTable(roomScans);
        await m.createTable(storageContainers);
        await m.createTable(storageSections);
        await m.createTable(inventoryItems);
        await m.createTable(checkoutRecords);
        await m.createTable(scanCandidates);
        await m.createTable(movementRecords);
      }
      if (from >= 2 && from < 3) {
        await m.addColumn(roomScans, roomScans.geometryJson);
        await m.addColumn(storageContainers, storageContainers.geometryJson);
      }
    },
  );

  Future<void> saveSpikeItem({required String id, required String name}) =>
      into(persistenceSpikeItems).insertOnConflictUpdate(
        PersistenceSpikeItemsCompanion.insert(id: id, name: name),
      );

  Future<PersistenceSpikeItem?> readSpikeItem(String id) => (select(
    persistenceSpikeItems,
  )..where((row) => row.id.equals(id))).getSingleOrNull();

  Future<void> updateSpikeStatus(String id, String status) =>
      (update(persistenceSpikeItems)..where((row) => row.id.equals(id))).write(
        PersistenceSpikeItemsCompanion(
          status: Value(status),
          updatedAt: Value(DateTime.now()),
        ),
      );
}
