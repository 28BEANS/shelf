import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class PersistenceSpikeItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get status => text().withDefault(const Constant('available'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [PersistenceSpikeItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(
        executor ??
            driftDatabase(
              name: 'shelf',
              web: DriftWebOptions(
                sqlite3Wasm: Uri.parse('sqlite3.wasm'),
                driftWorker: Uri.parse('drift_worker.js'),
              ),
            ),
      );

  @override
  int get schemaVersion => 1;

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
