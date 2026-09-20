// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PersistenceSpikeItemsTable extends PersistenceSpikeItems
    with TableInfo<$PersistenceSpikeItemsTable, PersistenceSpikeItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersistenceSpikeItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('available'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, status, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persistence_spike_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersistenceSpikeItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersistenceSpikeItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersistenceSpikeItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PersistenceSpikeItemsTable createAlias(String alias) {
    return $PersistenceSpikeItemsTable(attachedDatabase, alias);
  }
}

class PersistenceSpikeItem extends DataClass
    implements Insertable<PersistenceSpikeItem> {
  final String id;
  final String name;
  final String status;
  final DateTime updatedAt;
  const PersistenceSpikeItem({
    required this.id,
    required this.name,
    required this.status,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['status'] = Variable<String>(status);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PersistenceSpikeItemsCompanion toCompanion(bool nullToAbsent) {
    return PersistenceSpikeItemsCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      updatedAt: Value(updatedAt),
    );
  }

  factory PersistenceSpikeItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersistenceSpikeItem(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      status: serializer.fromJson<String>(json['status']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<String>(status),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PersistenceSpikeItem copyWith({
    String? id,
    String? name,
    String? status,
    DateTime? updatedAt,
  }) => PersistenceSpikeItem(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PersistenceSpikeItem copyWithCompanion(PersistenceSpikeItemsCompanion data) {
    return PersistenceSpikeItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersistenceSpikeItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, status, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersistenceSpikeItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.status == this.status &&
          other.updatedAt == this.updatedAt);
}

class PersistenceSpikeItemsCompanion
    extends UpdateCompanion<PersistenceSpikeItem> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> status;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PersistenceSpikeItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersistenceSpikeItemsCompanion.insert({
    required String id,
    required String name,
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<PersistenceSpikeItem> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? status,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersistenceSpikeItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? status,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PersistenceSpikeItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersistenceSpikeItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PersistenceSpikeItemsTable persistenceSpikeItems =
      $PersistenceSpikeItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [persistenceSpikeItems];
}

typedef $$PersistenceSpikeItemsTableCreateCompanionBuilder =
    PersistenceSpikeItemsCompanion Function({
      required String id,
      required String name,
      Value<String> status,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$PersistenceSpikeItemsTableUpdateCompanionBuilder =
    PersistenceSpikeItemsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> status,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$PersistenceSpikeItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PersistenceSpikeItemsTable> {
  $$PersistenceSpikeItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PersistenceSpikeItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersistenceSpikeItemsTable> {
  $$PersistenceSpikeItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersistenceSpikeItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersistenceSpikeItemsTable> {
  $$PersistenceSpikeItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PersistenceSpikeItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersistenceSpikeItemsTable,
          PersistenceSpikeItem,
          $$PersistenceSpikeItemsTableFilterComposer,
          $$PersistenceSpikeItemsTableOrderingComposer,
          $$PersistenceSpikeItemsTableAnnotationComposer,
          $$PersistenceSpikeItemsTableCreateCompanionBuilder,
          $$PersistenceSpikeItemsTableUpdateCompanionBuilder,
          (
            PersistenceSpikeItem,
            BaseReferences<
              _$AppDatabase,
              $PersistenceSpikeItemsTable,
              PersistenceSpikeItem
            >,
          ),
          PersistenceSpikeItem,
          PrefetchHooks Function()
        > {
  $$PersistenceSpikeItemsTableTableManager(
    _$AppDatabase db,
    $PersistenceSpikeItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersistenceSpikeItemsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PersistenceSpikeItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PersistenceSpikeItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersistenceSpikeItemsCompanion(
                id: id,
                name: name,
                status: status,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersistenceSpikeItemsCompanion.insert(
                id: id,
                name: name,
                status: status,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $PersistenceSpikeItemsTable,
                    PersistenceSpikeItem
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PersistenceSpikeItemsTable,
                    PersistenceSpikeItem
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PersistenceSpikeItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersistenceSpikeItemsTable,
      PersistenceSpikeItem,
      $$PersistenceSpikeItemsTableFilterComposer,
      $$PersistenceSpikeItemsTableOrderingComposer,
      $$PersistenceSpikeItemsTableAnnotationComposer,
      $$PersistenceSpikeItemsTableCreateCompanionBuilder,
      $$PersistenceSpikeItemsTableUpdateCompanionBuilder,
      (
        PersistenceSpikeItem,
        BaseReferences<
          _$AppDatabase,
          $PersistenceSpikeItemsTable,
          PersistenceSpikeItem
        >,
      ),
      PersistenceSpikeItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PersistenceSpikeItemsTableTableManager get persistenceSpikeItems =>
      $$PersistenceSpikeItemsTableTableManager(_db, _db.persistenceSpikeItems);
}
