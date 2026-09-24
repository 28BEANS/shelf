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

class $WorkspacesTable extends Workspaces
    with TableInfo<$WorkspacesTable, Workspace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkspacesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workspaces';
  @override
  VerificationContext validateIntegrity(
    Insertable<Workspace> instance, {
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
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workspace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workspace(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WorkspacesTable createAlias(String alias) {
    return $WorkspacesTable(attachedDatabase, alias);
  }
}

class Workspace extends DataClass implements Insertable<Workspace> {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  const Workspace({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WorkspacesCompanion toCompanion(bool nullToAbsent) {
    return WorkspacesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory Workspace.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workspace(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Workspace copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
  }) => Workspace(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  Workspace copyWithCompanion(WorkspacesCompanion data) {
    return Workspace(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Workspace(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workspace &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class WorkspacesCompanion extends UpdateCompanion<Workspace> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WorkspacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkspacesCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Workspace> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkspacesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WorkspacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkspacesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoomScansTable extends RoomScans
    with TableInfo<$RoomScansTable, RoomScan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomScansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _capturedAtMeta = const VerificationMeta(
    'capturedAt',
  );
  @override
  late final GeneratedColumn<DateTime> capturedAt = GeneratedColumn<DateTime>(
    'captured_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, workspaceId, source, capturedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'room_scans';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoomScan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('captured_at')) {
      context.handle(
        _capturedAtMeta,
        capturedAt.isAcceptableOrUnknown(data['captured_at']!, _capturedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoomScan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoomScan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      capturedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}captured_at'],
      )!,
    );
  }

  @override
  $RoomScansTable createAlias(String alias) {
    return $RoomScansTable(attachedDatabase, alias);
  }
}

class RoomScan extends DataClass implements Insertable<RoomScan> {
  final String id;
  final String workspaceId;
  final String source;
  final DateTime capturedAt;
  const RoomScan({
    required this.id,
    required this.workspaceId,
    required this.source,
    required this.capturedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['source'] = Variable<String>(source);
    map['captured_at'] = Variable<DateTime>(capturedAt);
    return map;
  }

  RoomScansCompanion toCompanion(bool nullToAbsent) {
    return RoomScansCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      source: Value(source),
      capturedAt: Value(capturedAt),
    );
  }

  factory RoomScan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoomScan(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      source: serializer.fromJson<String>(json['source']),
      capturedAt: serializer.fromJson<DateTime>(json['capturedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'source': serializer.toJson<String>(source),
      'capturedAt': serializer.toJson<DateTime>(capturedAt),
    };
  }

  RoomScan copyWith({
    String? id,
    String? workspaceId,
    String? source,
    DateTime? capturedAt,
  }) => RoomScan(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    source: source ?? this.source,
    capturedAt: capturedAt ?? this.capturedAt,
  );
  RoomScan copyWithCompanion(RoomScansCompanion data) {
    return RoomScan(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      source: data.source.present ? data.source.value : this.source,
      capturedAt: data.capturedAt.present
          ? data.capturedAt.value
          : this.capturedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoomScan(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('source: $source, ')
          ..write('capturedAt: $capturedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workspaceId, source, capturedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoomScan &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.source == this.source &&
          other.capturedAt == this.capturedAt);
}

class RoomScansCompanion extends UpdateCompanion<RoomScan> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> source;
  final Value<DateTime> capturedAt;
  final Value<int> rowid;
  const RoomScansCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.source = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoomScansCompanion.insert({
    required String id,
    required String workspaceId,
    required String source,
    this.capturedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       source = Value(source);
  static Insertable<RoomScan> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? source,
    Expression<DateTime>? capturedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (source != null) 'source': source,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoomScansCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String>? source,
    Value<DateTime>? capturedAt,
    Value<int>? rowid,
  }) {
    return RoomScansCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      source: source ?? this.source,
      capturedAt: capturedAt ?? this.capturedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<DateTime>(capturedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomScansCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('source: $source, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StorageContainersTable extends StorageContainers
    with TableInfo<$StorageContainersTable, StorageContainer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StorageContainersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
  );
  static const VerificationMeta _roomScanIdMeta = const VerificationMeta(
    'roomScanId',
  );
  @override
  late final GeneratedColumn<String> roomScanId = GeneratedColumn<String>(
    'room_scan_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES room_scans (id)',
    ),
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _layoutLabelMeta = const VerificationMeta(
    'layoutLabel',
  );
  @override
  late final GeneratedColumn<String> layoutLabel = GeneratedColumn<String>(
    'layout_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fromSampleScanMeta = const VerificationMeta(
    'fromSampleScan',
  );
  @override
  late final GeneratedColumn<bool> fromSampleScan = GeneratedColumn<bool>(
    'from_sample_scan',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("from_sample_scan" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workspaceId,
    roomScanId,
    name,
    type,
    layoutLabel,
    fromSampleScan,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'storage_containers';
  @override
  VerificationContext validateIntegrity(
    Insertable<StorageContainer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('room_scan_id')) {
      context.handle(
        _roomScanIdMeta,
        roomScanId.isAcceptableOrUnknown(
          data['room_scan_id']!,
          _roomScanIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('layout_label')) {
      context.handle(
        _layoutLabelMeta,
        layoutLabel.isAcceptableOrUnknown(
          data['layout_label']!,
          _layoutLabelMeta,
        ),
      );
    }
    if (data.containsKey('from_sample_scan')) {
      context.handle(
        _fromSampleScanMeta,
        fromSampleScan.isAcceptableOrUnknown(
          data['from_sample_scan']!,
          _fromSampleScanMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StorageContainer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StorageContainer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      roomScanId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room_scan_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      layoutLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}layout_label'],
      ),
      fromSampleScan: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}from_sample_scan'],
      )!,
    );
  }

  @override
  $StorageContainersTable createAlias(String alias) {
    return $StorageContainersTable(attachedDatabase, alias);
  }
}

class StorageContainer extends DataClass
    implements Insertable<StorageContainer> {
  final String id;
  final String workspaceId;
  final String? roomScanId;
  final String name;
  final String type;
  final String? layoutLabel;
  final bool fromSampleScan;
  const StorageContainer({
    required this.id,
    required this.workspaceId,
    this.roomScanId,
    required this.name,
    required this.type,
    this.layoutLabel,
    required this.fromSampleScan,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    if (!nullToAbsent || roomScanId != null) {
      map['room_scan_id'] = Variable<String>(roomScanId);
    }
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || layoutLabel != null) {
      map['layout_label'] = Variable<String>(layoutLabel);
    }
    map['from_sample_scan'] = Variable<bool>(fromSampleScan);
    return map;
  }

  StorageContainersCompanion toCompanion(bool nullToAbsent) {
    return StorageContainersCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      roomScanId: roomScanId == null && nullToAbsent
          ? const Value.absent()
          : Value(roomScanId),
      name: Value(name),
      type: Value(type),
      layoutLabel: layoutLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(layoutLabel),
      fromSampleScan: Value(fromSampleScan),
    );
  }

  factory StorageContainer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StorageContainer(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      roomScanId: serializer.fromJson<String?>(json['roomScanId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      layoutLabel: serializer.fromJson<String?>(json['layoutLabel']),
      fromSampleScan: serializer.fromJson<bool>(json['fromSampleScan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'roomScanId': serializer.toJson<String?>(roomScanId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'layoutLabel': serializer.toJson<String?>(layoutLabel),
      'fromSampleScan': serializer.toJson<bool>(fromSampleScan),
    };
  }

  StorageContainer copyWith({
    String? id,
    String? workspaceId,
    Value<String?> roomScanId = const Value.absent(),
    String? name,
    String? type,
    Value<String?> layoutLabel = const Value.absent(),
    bool? fromSampleScan,
  }) => StorageContainer(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    roomScanId: roomScanId.present ? roomScanId.value : this.roomScanId,
    name: name ?? this.name,
    type: type ?? this.type,
    layoutLabel: layoutLabel.present ? layoutLabel.value : this.layoutLabel,
    fromSampleScan: fromSampleScan ?? this.fromSampleScan,
  );
  StorageContainer copyWithCompanion(StorageContainersCompanion data) {
    return StorageContainer(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      roomScanId: data.roomScanId.present
          ? data.roomScanId.value
          : this.roomScanId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      layoutLabel: data.layoutLabel.present
          ? data.layoutLabel.value
          : this.layoutLabel,
      fromSampleScan: data.fromSampleScan.present
          ? data.fromSampleScan.value
          : this.fromSampleScan,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StorageContainer(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('roomScanId: $roomScanId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('layoutLabel: $layoutLabel, ')
          ..write('fromSampleScan: $fromSampleScan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceId,
    roomScanId,
    name,
    type,
    layoutLabel,
    fromSampleScan,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StorageContainer &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.roomScanId == this.roomScanId &&
          other.name == this.name &&
          other.type == this.type &&
          other.layoutLabel == this.layoutLabel &&
          other.fromSampleScan == this.fromSampleScan);
}

class StorageContainersCompanion extends UpdateCompanion<StorageContainer> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String?> roomScanId;
  final Value<String> name;
  final Value<String> type;
  final Value<String?> layoutLabel;
  final Value<bool> fromSampleScan;
  final Value<int> rowid;
  const StorageContainersCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.roomScanId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.layoutLabel = const Value.absent(),
    this.fromSampleScan = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StorageContainersCompanion.insert({
    required String id,
    required String workspaceId,
    this.roomScanId = const Value.absent(),
    required String name,
    required String type,
    this.layoutLabel = const Value.absent(),
    this.fromSampleScan = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       name = Value(name),
       type = Value(type);
  static Insertable<StorageContainer> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? roomScanId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? layoutLabel,
    Expression<bool>? fromSampleScan,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (roomScanId != null) 'room_scan_id': roomScanId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (layoutLabel != null) 'layout_label': layoutLabel,
      if (fromSampleScan != null) 'from_sample_scan': fromSampleScan,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StorageContainersCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String?>? roomScanId,
    Value<String>? name,
    Value<String>? type,
    Value<String?>? layoutLabel,
    Value<bool>? fromSampleScan,
    Value<int>? rowid,
  }) {
    return StorageContainersCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      roomScanId: roomScanId ?? this.roomScanId,
      name: name ?? this.name,
      type: type ?? this.type,
      layoutLabel: layoutLabel ?? this.layoutLabel,
      fromSampleScan: fromSampleScan ?? this.fromSampleScan,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (roomScanId.present) {
      map['room_scan_id'] = Variable<String>(roomScanId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (layoutLabel.present) {
      map['layout_label'] = Variable<String>(layoutLabel.value);
    }
    if (fromSampleScan.present) {
      map['from_sample_scan'] = Variable<bool>(fromSampleScan.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StorageContainersCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('roomScanId: $roomScanId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('layoutLabel: $layoutLabel, ')
          ..write('fromSampleScan: $fromSampleScan, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StorageSectionsTable extends StorageSections
    with TableInfo<$StorageSectionsTable, StorageSection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StorageSectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _containerIdMeta = const VerificationMeta(
    'containerId',
  );
  @override
  late final GeneratedColumn<String> containerId = GeneratedColumn<String>(
    'container_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES storage_containers (id)',
    ),
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
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, containerId, name, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'storage_sections';
  @override
  VerificationContext validateIntegrity(
    Insertable<StorageSection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('container_id')) {
      context.handle(
        _containerIdMeta,
        containerId.isAcceptableOrUnknown(
          data['container_id']!,
          _containerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_containerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StorageSection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StorageSection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      containerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}container_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $StorageSectionsTable createAlias(String alias) {
    return $StorageSectionsTable(attachedDatabase, alias);
  }
}

class StorageSection extends DataClass implements Insertable<StorageSection> {
  final String id;
  final String containerId;
  final String name;
  final int sortOrder;
  const StorageSection({
    required this.id,
    required this.containerId,
    required this.name,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['container_id'] = Variable<String>(containerId);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  StorageSectionsCompanion toCompanion(bool nullToAbsent) {
    return StorageSectionsCompanion(
      id: Value(id),
      containerId: Value(containerId),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory StorageSection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StorageSection(
      id: serializer.fromJson<String>(json['id']),
      containerId: serializer.fromJson<String>(json['containerId']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'containerId': serializer.toJson<String>(containerId),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  StorageSection copyWith({
    String? id,
    String? containerId,
    String? name,
    int? sortOrder,
  }) => StorageSection(
    id: id ?? this.id,
    containerId: containerId ?? this.containerId,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  StorageSection copyWithCompanion(StorageSectionsCompanion data) {
    return StorageSection(
      id: data.id.present ? data.id.value : this.id,
      containerId: data.containerId.present
          ? data.containerId.value
          : this.containerId,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StorageSection(')
          ..write('id: $id, ')
          ..write('containerId: $containerId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, containerId, name, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StorageSection &&
          other.id == this.id &&
          other.containerId == this.containerId &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class StorageSectionsCompanion extends UpdateCompanion<StorageSection> {
  final Value<String> id;
  final Value<String> containerId;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const StorageSectionsCompanion({
    this.id = const Value.absent(),
    this.containerId = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StorageSectionsCompanion.insert({
    required String id,
    required String containerId,
    required String name,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       containerId = Value(containerId),
       name = Value(name),
       sortOrder = Value(sortOrder);
  static Insertable<StorageSection> custom({
    Expression<String>? id,
    Expression<String>? containerId,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (containerId != null) 'container_id': containerId,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StorageSectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? containerId,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return StorageSectionsCompanion(
      id: id ?? this.id,
      containerId: containerId ?? this.containerId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (containerId.present) {
      map['container_id'] = Variable<String>(containerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StorageSectionsCompanion(')
          ..write('id: $id, ')
          ..write('containerId: $containerId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workspaceIdMeta = const VerificationMeta(
    'workspaceId',
  );
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
    'workspace_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workspaces (id)',
    ),
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
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Equipment'),
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _identifierMeta = const VerificationMeta(
    'identifier',
  );
  @override
  late final GeneratedColumn<String> identifier = GeneratedColumn<String>(
    'identifier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
  static const VerificationMeta _homeSectionIdMeta = const VerificationMeta(
    'homeSectionId',
  );
  @override
  late final GeneratedColumn<String> homeSectionId = GeneratedColumn<String>(
    'home_section_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES storage_sections (id)',
    ),
  );
  static const VerificationMeta _currentSectionIdMeta = const VerificationMeta(
    'currentSectionId',
  );
  @override
  late final GeneratedColumn<String> currentSectionId = GeneratedColumn<String>(
    'current_section_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES storage_sections (id)',
    ),
  );
  static const VerificationMeta _sourceCandidateIdMeta = const VerificationMeta(
    'sourceCandidateId',
  );
  @override
  late final GeneratedColumn<String> sourceCandidateId =
      GeneratedColumn<String>(
        'source_candidate_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastConfirmedAtMeta = const VerificationMeta(
    'lastConfirmedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastConfirmedAt =
      GeneratedColumn<DateTime>(
        'last_confirmed_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workspaceId,
    name,
    category,
    model,
    identifier,
    status,
    homeSectionId,
    currentSectionId,
    sourceCandidateId,
    lastConfirmedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
        _workspaceIdMeta,
        workspaceId.isAcceptableOrUnknown(
          data['workspace_id']!,
          _workspaceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('identifier')) {
      context.handle(
        _identifierMeta,
        identifier.isAcceptableOrUnknown(data['identifier']!, _identifierMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('home_section_id')) {
      context.handle(
        _homeSectionIdMeta,
        homeSectionId.isAcceptableOrUnknown(
          data['home_section_id']!,
          _homeSectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_homeSectionIdMeta);
    }
    if (data.containsKey('current_section_id')) {
      context.handle(
        _currentSectionIdMeta,
        currentSectionId.isAcceptableOrUnknown(
          data['current_section_id']!,
          _currentSectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentSectionIdMeta);
    }
    if (data.containsKey('source_candidate_id')) {
      context.handle(
        _sourceCandidateIdMeta,
        sourceCandidateId.isAcceptableOrUnknown(
          data['source_candidate_id']!,
          _sourceCandidateIdMeta,
        ),
      );
    }
    if (data.containsKey('last_confirmed_at')) {
      context.handle(
        _lastConfirmedAtMeta,
        lastConfirmedAt.isAcceptableOrUnknown(
          data['last_confirmed_at']!,
          _lastConfirmedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workspaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workspace_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      identifier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identifier'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      homeSectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}home_section_id'],
      )!,
      currentSectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_section_id'],
      )!,
      sourceCandidateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_candidate_id'],
      ),
      lastConfirmedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_confirmed_at'],
      )!,
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItem extends DataClass implements Insertable<InventoryItem> {
  final String id;
  final String workspaceId;
  final String name;
  final String category;
  final String model;
  final String identifier;
  final String status;
  final String homeSectionId;
  final String currentSectionId;
  final String? sourceCandidateId;
  final DateTime lastConfirmedAt;
  const InventoryItem({
    required this.id,
    required this.workspaceId,
    required this.name,
    required this.category,
    required this.model,
    required this.identifier,
    required this.status,
    required this.homeSectionId,
    required this.currentSectionId,
    this.sourceCandidateId,
    required this.lastConfirmedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['model'] = Variable<String>(model);
    map['identifier'] = Variable<String>(identifier);
    map['status'] = Variable<String>(status);
    map['home_section_id'] = Variable<String>(homeSectionId);
    map['current_section_id'] = Variable<String>(currentSectionId);
    if (!nullToAbsent || sourceCandidateId != null) {
      map['source_candidate_id'] = Variable<String>(sourceCandidateId);
    }
    map['last_confirmed_at'] = Variable<DateTime>(lastConfirmedAt);
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      name: Value(name),
      category: Value(category),
      model: Value(model),
      identifier: Value(identifier),
      status: Value(status),
      homeSectionId: Value(homeSectionId),
      currentSectionId: Value(currentSectionId),
      sourceCandidateId: sourceCandidateId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceCandidateId),
      lastConfirmedAt: Value(lastConfirmedAt),
    );
  }

  factory InventoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItem(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      model: serializer.fromJson<String>(json['model']),
      identifier: serializer.fromJson<String>(json['identifier']),
      status: serializer.fromJson<String>(json['status']),
      homeSectionId: serializer.fromJson<String>(json['homeSectionId']),
      currentSectionId: serializer.fromJson<String>(json['currentSectionId']),
      sourceCandidateId: serializer.fromJson<String?>(
        json['sourceCandidateId'],
      ),
      lastConfirmedAt: serializer.fromJson<DateTime>(json['lastConfirmedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'model': serializer.toJson<String>(model),
      'identifier': serializer.toJson<String>(identifier),
      'status': serializer.toJson<String>(status),
      'homeSectionId': serializer.toJson<String>(homeSectionId),
      'currentSectionId': serializer.toJson<String>(currentSectionId),
      'sourceCandidateId': serializer.toJson<String?>(sourceCandidateId),
      'lastConfirmedAt': serializer.toJson<DateTime>(lastConfirmedAt),
    };
  }

  InventoryItem copyWith({
    String? id,
    String? workspaceId,
    String? name,
    String? category,
    String? model,
    String? identifier,
    String? status,
    String? homeSectionId,
    String? currentSectionId,
    Value<String?> sourceCandidateId = const Value.absent(),
    DateTime? lastConfirmedAt,
  }) => InventoryItem(
    id: id ?? this.id,
    workspaceId: workspaceId ?? this.workspaceId,
    name: name ?? this.name,
    category: category ?? this.category,
    model: model ?? this.model,
    identifier: identifier ?? this.identifier,
    status: status ?? this.status,
    homeSectionId: homeSectionId ?? this.homeSectionId,
    currentSectionId: currentSectionId ?? this.currentSectionId,
    sourceCandidateId: sourceCandidateId.present
        ? sourceCandidateId.value
        : this.sourceCandidateId,
    lastConfirmedAt: lastConfirmedAt ?? this.lastConfirmedAt,
  );
  InventoryItem copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItem(
      id: data.id.present ? data.id.value : this.id,
      workspaceId: data.workspaceId.present
          ? data.workspaceId.value
          : this.workspaceId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      model: data.model.present ? data.model.value : this.model,
      identifier: data.identifier.present
          ? data.identifier.value
          : this.identifier,
      status: data.status.present ? data.status.value : this.status,
      homeSectionId: data.homeSectionId.present
          ? data.homeSectionId.value
          : this.homeSectionId,
      currentSectionId: data.currentSectionId.present
          ? data.currentSectionId.value
          : this.currentSectionId,
      sourceCandidateId: data.sourceCandidateId.present
          ? data.sourceCandidateId.value
          : this.sourceCandidateId,
      lastConfirmedAt: data.lastConfirmedAt.present
          ? data.lastConfirmedAt.value
          : this.lastConfirmedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItem(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('model: $model, ')
          ..write('identifier: $identifier, ')
          ..write('status: $status, ')
          ..write('homeSectionId: $homeSectionId, ')
          ..write('currentSectionId: $currentSectionId, ')
          ..write('sourceCandidateId: $sourceCandidateId, ')
          ..write('lastConfirmedAt: $lastConfirmedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workspaceId,
    name,
    category,
    model,
    identifier,
    status,
    homeSectionId,
    currentSectionId,
    sourceCandidateId,
    lastConfirmedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItem &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.name == this.name &&
          other.category == this.category &&
          other.model == this.model &&
          other.identifier == this.identifier &&
          other.status == this.status &&
          other.homeSectionId == this.homeSectionId &&
          other.currentSectionId == this.currentSectionId &&
          other.sourceCandidateId == this.sourceCandidateId &&
          other.lastConfirmedAt == this.lastConfirmedAt);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItem> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> name;
  final Value<String> category;
  final Value<String> model;
  final Value<String> identifier;
  final Value<String> status;
  final Value<String> homeSectionId;
  final Value<String> currentSectionId;
  final Value<String?> sourceCandidateId;
  final Value<DateTime> lastConfirmedAt;
  final Value<int> rowid;
  const InventoryItemsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.model = const Value.absent(),
    this.identifier = const Value.absent(),
    this.status = const Value.absent(),
    this.homeSectionId = const Value.absent(),
    this.currentSectionId = const Value.absent(),
    this.sourceCandidateId = const Value.absent(),
    this.lastConfirmedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    required String id,
    required String workspaceId,
    required String name,
    this.category = const Value.absent(),
    this.model = const Value.absent(),
    this.identifier = const Value.absent(),
    this.status = const Value.absent(),
    required String homeSectionId,
    required String currentSectionId,
    this.sourceCandidateId = const Value.absent(),
    this.lastConfirmedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workspaceId = Value(workspaceId),
       name = Value(name),
       homeSectionId = Value(homeSectionId),
       currentSectionId = Value(currentSectionId);
  static Insertable<InventoryItem> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? model,
    Expression<String>? identifier,
    Expression<String>? status,
    Expression<String>? homeSectionId,
    Expression<String>? currentSectionId,
    Expression<String>? sourceCandidateId,
    Expression<DateTime>? lastConfirmedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (model != null) 'model': model,
      if (identifier != null) 'identifier': identifier,
      if (status != null) 'status': status,
      if (homeSectionId != null) 'home_section_id': homeSectionId,
      if (currentSectionId != null) 'current_section_id': currentSectionId,
      if (sourceCandidateId != null) 'source_candidate_id': sourceCandidateId,
      if (lastConfirmedAt != null) 'last_confirmed_at': lastConfirmedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? workspaceId,
    Value<String>? name,
    Value<String>? category,
    Value<String>? model,
    Value<String>? identifier,
    Value<String>? status,
    Value<String>? homeSectionId,
    Value<String>? currentSectionId,
    Value<String?>? sourceCandidateId,
    Value<DateTime>? lastConfirmedAt,
    Value<int>? rowid,
  }) {
    return InventoryItemsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      name: name ?? this.name,
      category: category ?? this.category,
      model: model ?? this.model,
      identifier: identifier ?? this.identifier,
      status: status ?? this.status,
      homeSectionId: homeSectionId ?? this.homeSectionId,
      currentSectionId: currentSectionId ?? this.currentSectionId,
      sourceCandidateId: sourceCandidateId ?? this.sourceCandidateId,
      lastConfirmedAt: lastConfirmedAt ?? this.lastConfirmedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (identifier.present) {
      map['identifier'] = Variable<String>(identifier.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (homeSectionId.present) {
      map['home_section_id'] = Variable<String>(homeSectionId.value);
    }
    if (currentSectionId.present) {
      map['current_section_id'] = Variable<String>(currentSectionId.value);
    }
    if (sourceCandidateId.present) {
      map['source_candidate_id'] = Variable<String>(sourceCandidateId.value);
    }
    if (lastConfirmedAt.present) {
      map['last_confirmed_at'] = Variable<DateTime>(lastConfirmedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('model: $model, ')
          ..write('identifier: $identifier, ')
          ..write('status: $status, ')
          ..write('homeSectionId: $homeSectionId, ')
          ..write('currentSectionId: $currentSectionId, ')
          ..write('sourceCandidateId: $sourceCandidateId, ')
          ..write('lastConfirmedAt: $lastConfirmedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CheckoutRecordsTable extends CheckoutRecords
    with TableInfo<$CheckoutRecordsTable, CheckoutRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckoutRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES inventory_items (id)',
    ),
  );
  static const VerificationMeta _borrowerMeta = const VerificationMeta(
    'borrower',
  );
  @override
  late final GeneratedColumn<String> borrower = GeneratedColumn<String>(
    'borrower',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkedOutAtMeta = const VerificationMeta(
    'checkedOutAt',
  );
  @override
  late final GeneratedColumn<DateTime> checkedOutAt = GeneratedColumn<DateTime>(
    'checked_out_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _returnedAtMeta = const VerificationMeta(
    'returnedAt',
  );
  @override
  late final GeneratedColumn<DateTime> returnedAt = GeneratedColumn<DateTime>(
    'returned_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conditionMeta = const VerificationMeta(
    'condition',
  );
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
    'condition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Good'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemId,
    borrower,
    dueAt,
    checkedOutAt,
    returnedAt,
    condition,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checkout_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckoutRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('borrower')) {
      context.handle(
        _borrowerMeta,
        borrower.isAcceptableOrUnknown(data['borrower']!, _borrowerMeta),
      );
    } else if (isInserting) {
      context.missing(_borrowerMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    } else if (isInserting) {
      context.missing(_dueAtMeta);
    }
    if (data.containsKey('checked_out_at')) {
      context.handle(
        _checkedOutAtMeta,
        checkedOutAt.isAcceptableOrUnknown(
          data['checked_out_at']!,
          _checkedOutAtMeta,
        ),
      );
    }
    if (data.containsKey('returned_at')) {
      context.handle(
        _returnedAtMeta,
        returnedAt.isAcceptableOrUnknown(data['returned_at']!, _returnedAtMeta),
      );
    }
    if (data.containsKey('condition')) {
      context.handle(
        _conditionMeta,
        condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheckoutRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckoutRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      borrower: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}borrower'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      )!,
      checkedOutAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}checked_out_at'],
      )!,
      returnedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}returned_at'],
      ),
      condition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $CheckoutRecordsTable createAlias(String alias) {
    return $CheckoutRecordsTable(attachedDatabase, alias);
  }
}

class CheckoutRecord extends DataClass implements Insertable<CheckoutRecord> {
  final String id;
  final String itemId;
  final String borrower;
  final DateTime dueAt;
  final DateTime checkedOutAt;
  final DateTime? returnedAt;
  final String condition;
  final String notes;
  const CheckoutRecord({
    required this.id,
    required this.itemId,
    required this.borrower,
    required this.dueAt,
    required this.checkedOutAt,
    this.returnedAt,
    required this.condition,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_id'] = Variable<String>(itemId);
    map['borrower'] = Variable<String>(borrower);
    map['due_at'] = Variable<DateTime>(dueAt);
    map['checked_out_at'] = Variable<DateTime>(checkedOutAt);
    if (!nullToAbsent || returnedAt != null) {
      map['returned_at'] = Variable<DateTime>(returnedAt);
    }
    map['condition'] = Variable<String>(condition);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  CheckoutRecordsCompanion toCompanion(bool nullToAbsent) {
    return CheckoutRecordsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      borrower: Value(borrower),
      dueAt: Value(dueAt),
      checkedOutAt: Value(checkedOutAt),
      returnedAt: returnedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(returnedAt),
      condition: Value(condition),
      notes: Value(notes),
    );
  }

  factory CheckoutRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckoutRecord(
      id: serializer.fromJson<String>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      borrower: serializer.fromJson<String>(json['borrower']),
      dueAt: serializer.fromJson<DateTime>(json['dueAt']),
      checkedOutAt: serializer.fromJson<DateTime>(json['checkedOutAt']),
      returnedAt: serializer.fromJson<DateTime?>(json['returnedAt']),
      condition: serializer.fromJson<String>(json['condition']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemId': serializer.toJson<String>(itemId),
      'borrower': serializer.toJson<String>(borrower),
      'dueAt': serializer.toJson<DateTime>(dueAt),
      'checkedOutAt': serializer.toJson<DateTime>(checkedOutAt),
      'returnedAt': serializer.toJson<DateTime?>(returnedAt),
      'condition': serializer.toJson<String>(condition),
      'notes': serializer.toJson<String>(notes),
    };
  }

  CheckoutRecord copyWith({
    String? id,
    String? itemId,
    String? borrower,
    DateTime? dueAt,
    DateTime? checkedOutAt,
    Value<DateTime?> returnedAt = const Value.absent(),
    String? condition,
    String? notes,
  }) => CheckoutRecord(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    borrower: borrower ?? this.borrower,
    dueAt: dueAt ?? this.dueAt,
    checkedOutAt: checkedOutAt ?? this.checkedOutAt,
    returnedAt: returnedAt.present ? returnedAt.value : this.returnedAt,
    condition: condition ?? this.condition,
    notes: notes ?? this.notes,
  );
  CheckoutRecord copyWithCompanion(CheckoutRecordsCompanion data) {
    return CheckoutRecord(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      borrower: data.borrower.present ? data.borrower.value : this.borrower,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      checkedOutAt: data.checkedOutAt.present
          ? data.checkedOutAt.value
          : this.checkedOutAt,
      returnedAt: data.returnedAt.present
          ? data.returnedAt.value
          : this.returnedAt,
      condition: data.condition.present ? data.condition.value : this.condition,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheckoutRecord(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('borrower: $borrower, ')
          ..write('dueAt: $dueAt, ')
          ..write('checkedOutAt: $checkedOutAt, ')
          ..write('returnedAt: $returnedAt, ')
          ..write('condition: $condition, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itemId,
    borrower,
    dueAt,
    checkedOutAt,
    returnedAt,
    condition,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckoutRecord &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.borrower == this.borrower &&
          other.dueAt == this.dueAt &&
          other.checkedOutAt == this.checkedOutAt &&
          other.returnedAt == this.returnedAt &&
          other.condition == this.condition &&
          other.notes == this.notes);
}

class CheckoutRecordsCompanion extends UpdateCompanion<CheckoutRecord> {
  final Value<String> id;
  final Value<String> itemId;
  final Value<String> borrower;
  final Value<DateTime> dueAt;
  final Value<DateTime> checkedOutAt;
  final Value<DateTime?> returnedAt;
  final Value<String> condition;
  final Value<String> notes;
  final Value<int> rowid;
  const CheckoutRecordsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.borrower = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.checkedOutAt = const Value.absent(),
    this.returnedAt = const Value.absent(),
    this.condition = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CheckoutRecordsCompanion.insert({
    required String id,
    required String itemId,
    required String borrower,
    required DateTime dueAt,
    this.checkedOutAt = const Value.absent(),
    this.returnedAt = const Value.absent(),
    this.condition = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       itemId = Value(itemId),
       borrower = Value(borrower),
       dueAt = Value(dueAt);
  static Insertable<CheckoutRecord> custom({
    Expression<String>? id,
    Expression<String>? itemId,
    Expression<String>? borrower,
    Expression<DateTime>? dueAt,
    Expression<DateTime>? checkedOutAt,
    Expression<DateTime>? returnedAt,
    Expression<String>? condition,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (borrower != null) 'borrower': borrower,
      if (dueAt != null) 'due_at': dueAt,
      if (checkedOutAt != null) 'checked_out_at': checkedOutAt,
      if (returnedAt != null) 'returned_at': returnedAt,
      if (condition != null) 'condition': condition,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CheckoutRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? itemId,
    Value<String>? borrower,
    Value<DateTime>? dueAt,
    Value<DateTime>? checkedOutAt,
    Value<DateTime?>? returnedAt,
    Value<String>? condition,
    Value<String>? notes,
    Value<int>? rowid,
  }) {
    return CheckoutRecordsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      borrower: borrower ?? this.borrower,
      dueAt: dueAt ?? this.dueAt,
      checkedOutAt: checkedOutAt ?? this.checkedOutAt,
      returnedAt: returnedAt ?? this.returnedAt,
      condition: condition ?? this.condition,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (borrower.present) {
      map['borrower'] = Variable<String>(borrower.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (checkedOutAt.present) {
      map['checked_out_at'] = Variable<DateTime>(checkedOutAt.value);
    }
    if (returnedAt.present) {
      map['returned_at'] = Variable<DateTime>(returnedAt.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckoutRecordsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('borrower: $borrower, ')
          ..write('dueAt: $dueAt, ')
          ..write('checkedOutAt: $checkedOutAt, ')
          ..write('returnedAt: $returnedAt, ')
          ..write('condition: $condition, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScanCandidatesTable extends ScanCandidates
    with TableInfo<$ScanCandidatesTable, ScanCandidate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanCandidatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sectionIdMeta = const VerificationMeta(
    'sectionId',
  );
  @override
  late final GeneratedColumn<String> sectionId = GeneratedColumn<String>(
    'section_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES storage_sections (id)',
    ),
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
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Equipment'),
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _identifierMeta = const VerificationMeta(
    'identifier',
  );
  @override
  late final GeneratedColumn<String> identifier = GeneratedColumn<String>(
    'identifier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sectionId,
    name,
    category,
    model,
    identifier,
    confidence,
    state,
    source,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_candidates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanCandidate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('section_id')) {
      context.handle(
        _sectionIdMeta,
        sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sectionIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    }
    if (data.containsKey('identifier')) {
      context.handle(
        _identifierMeta,
        identifier.isAcceptableOrUnknown(data['identifier']!, _identifierMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanCandidate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanCandidate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      identifier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identifier'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ScanCandidatesTable createAlias(String alias) {
    return $ScanCandidatesTable(attachedDatabase, alias);
  }
}

class ScanCandidate extends DataClass implements Insertable<ScanCandidate> {
  final String id;
  final String sectionId;
  final String name;
  final String category;
  final String model;
  final String identifier;
  final double confidence;
  final String state;
  final String source;
  final DateTime createdAt;
  const ScanCandidate({
    required this.id,
    required this.sectionId,
    required this.name,
    required this.category,
    required this.model,
    required this.identifier,
    required this.confidence,
    required this.state,
    required this.source,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['section_id'] = Variable<String>(sectionId);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['model'] = Variable<String>(model);
    map['identifier'] = Variable<String>(identifier);
    map['confidence'] = Variable<double>(confidence);
    map['state'] = Variable<String>(state);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ScanCandidatesCompanion toCompanion(bool nullToAbsent) {
    return ScanCandidatesCompanion(
      id: Value(id),
      sectionId: Value(sectionId),
      name: Value(name),
      category: Value(category),
      model: Value(model),
      identifier: Value(identifier),
      confidence: Value(confidence),
      state: Value(state),
      source: Value(source),
      createdAt: Value(createdAt),
    );
  }

  factory ScanCandidate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanCandidate(
      id: serializer.fromJson<String>(json['id']),
      sectionId: serializer.fromJson<String>(json['sectionId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      model: serializer.fromJson<String>(json['model']),
      identifier: serializer.fromJson<String>(json['identifier']),
      confidence: serializer.fromJson<double>(json['confidence']),
      state: serializer.fromJson<String>(json['state']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sectionId': serializer.toJson<String>(sectionId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'model': serializer.toJson<String>(model),
      'identifier': serializer.toJson<String>(identifier),
      'confidence': serializer.toJson<double>(confidence),
      'state': serializer.toJson<String>(state),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ScanCandidate copyWith({
    String? id,
    String? sectionId,
    String? name,
    String? category,
    String? model,
    String? identifier,
    double? confidence,
    String? state,
    String? source,
    DateTime? createdAt,
  }) => ScanCandidate(
    id: id ?? this.id,
    sectionId: sectionId ?? this.sectionId,
    name: name ?? this.name,
    category: category ?? this.category,
    model: model ?? this.model,
    identifier: identifier ?? this.identifier,
    confidence: confidence ?? this.confidence,
    state: state ?? this.state,
    source: source ?? this.source,
    createdAt: createdAt ?? this.createdAt,
  );
  ScanCandidate copyWithCompanion(ScanCandidatesCompanion data) {
    return ScanCandidate(
      id: data.id.present ? data.id.value : this.id,
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      model: data.model.present ? data.model.value : this.model,
      identifier: data.identifier.present
          ? data.identifier.value
          : this.identifier,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      state: data.state.present ? data.state.value : this.state,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanCandidate(')
          ..write('id: $id, ')
          ..write('sectionId: $sectionId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('model: $model, ')
          ..write('identifier: $identifier, ')
          ..write('confidence: $confidence, ')
          ..write('state: $state, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sectionId,
    name,
    category,
    model,
    identifier,
    confidence,
    state,
    source,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanCandidate &&
          other.id == this.id &&
          other.sectionId == this.sectionId &&
          other.name == this.name &&
          other.category == this.category &&
          other.model == this.model &&
          other.identifier == this.identifier &&
          other.confidence == this.confidence &&
          other.state == this.state &&
          other.source == this.source &&
          other.createdAt == this.createdAt);
}

class ScanCandidatesCompanion extends UpdateCompanion<ScanCandidate> {
  final Value<String> id;
  final Value<String> sectionId;
  final Value<String> name;
  final Value<String> category;
  final Value<String> model;
  final Value<String> identifier;
  final Value<double> confidence;
  final Value<String> state;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ScanCandidatesCompanion({
    this.id = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.model = const Value.absent(),
    this.identifier = const Value.absent(),
    this.confidence = const Value.absent(),
    this.state = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScanCandidatesCompanion.insert({
    required String id,
    required String sectionId,
    required String name,
    this.category = const Value.absent(),
    this.model = const Value.absent(),
    this.identifier = const Value.absent(),
    this.confidence = const Value.absent(),
    this.state = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sectionId = Value(sectionId),
       name = Value(name);
  static Insertable<ScanCandidate> custom({
    Expression<String>? id,
    Expression<String>? sectionId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? model,
    Expression<String>? identifier,
    Expression<double>? confidence,
    Expression<String>? state,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sectionId != null) 'section_id': sectionId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (model != null) 'model': model,
      if (identifier != null) 'identifier': identifier,
      if (confidence != null) 'confidence': confidence,
      if (state != null) 'state': state,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScanCandidatesCompanion copyWith({
    Value<String>? id,
    Value<String>? sectionId,
    Value<String>? name,
    Value<String>? category,
    Value<String>? model,
    Value<String>? identifier,
    Value<double>? confidence,
    Value<String>? state,
    Value<String>? source,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ScanCandidatesCompanion(
      id: id ?? this.id,
      sectionId: sectionId ?? this.sectionId,
      name: name ?? this.name,
      category: category ?? this.category,
      model: model ?? this.model,
      identifier: identifier ?? this.identifier,
      confidence: confidence ?? this.confidence,
      state: state ?? this.state,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sectionId.present) {
      map['section_id'] = Variable<String>(sectionId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (identifier.present) {
      map['identifier'] = Variable<String>(identifier.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanCandidatesCompanion(')
          ..write('id: $id, ')
          ..write('sectionId: $sectionId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('model: $model, ')
          ..write('identifier: $identifier, ')
          ..write('confidence: $confidence, ')
          ..write('state: $state, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MovementRecordsTable extends MovementRecords
    with TableInfo<$MovementRecordsTable, MovementRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovementRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES inventory_items (id)',
    ),
  );
  static const VerificationMeta _fromSectionIdMeta = const VerificationMeta(
    'fromSectionId',
  );
  @override
  late final GeneratedColumn<String> fromSectionId = GeneratedColumn<String>(
    'from_section_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES storage_sections (id)',
    ),
  );
  static const VerificationMeta _toSectionIdMeta = const VerificationMeta(
    'toSectionId',
  );
  @override
  late final GeneratedColumn<String> toSectionId = GeneratedColumn<String>(
    'to_section_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES storage_sections (id)',
    ),
  );
  static const VerificationMeta _movedAtMeta = const VerificationMeta(
    'movedAt',
  );
  @override
  late final GeneratedColumn<DateTime> movedAt = GeneratedColumn<DateTime>(
    'moved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemId,
    fromSectionId,
    toSectionId,
    movedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movement_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovementRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('from_section_id')) {
      context.handle(
        _fromSectionIdMeta,
        fromSectionId.isAcceptableOrUnknown(
          data['from_section_id']!,
          _fromSectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromSectionIdMeta);
    }
    if (data.containsKey('to_section_id')) {
      context.handle(
        _toSectionIdMeta,
        toSectionId.isAcceptableOrUnknown(
          data['to_section_id']!,
          _toSectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_toSectionIdMeta);
    }
    if (data.containsKey('moved_at')) {
      context.handle(
        _movedAtMeta,
        movedAt.isAcceptableOrUnknown(data['moved_at']!, _movedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovementRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovementRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      fromSectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_section_id'],
      )!,
      toSectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_section_id'],
      )!,
      movedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}moved_at'],
      )!,
    );
  }

  @override
  $MovementRecordsTable createAlias(String alias) {
    return $MovementRecordsTable(attachedDatabase, alias);
  }
}

class MovementRecord extends DataClass implements Insertable<MovementRecord> {
  final String id;
  final String itemId;
  final String fromSectionId;
  final String toSectionId;
  final DateTime movedAt;
  const MovementRecord({
    required this.id,
    required this.itemId,
    required this.fromSectionId,
    required this.toSectionId,
    required this.movedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_id'] = Variable<String>(itemId);
    map['from_section_id'] = Variable<String>(fromSectionId);
    map['to_section_id'] = Variable<String>(toSectionId);
    map['moved_at'] = Variable<DateTime>(movedAt);
    return map;
  }

  MovementRecordsCompanion toCompanion(bool nullToAbsent) {
    return MovementRecordsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      fromSectionId: Value(fromSectionId),
      toSectionId: Value(toSectionId),
      movedAt: Value(movedAt),
    );
  }

  factory MovementRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovementRecord(
      id: serializer.fromJson<String>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      fromSectionId: serializer.fromJson<String>(json['fromSectionId']),
      toSectionId: serializer.fromJson<String>(json['toSectionId']),
      movedAt: serializer.fromJson<DateTime>(json['movedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemId': serializer.toJson<String>(itemId),
      'fromSectionId': serializer.toJson<String>(fromSectionId),
      'toSectionId': serializer.toJson<String>(toSectionId),
      'movedAt': serializer.toJson<DateTime>(movedAt),
    };
  }

  MovementRecord copyWith({
    String? id,
    String? itemId,
    String? fromSectionId,
    String? toSectionId,
    DateTime? movedAt,
  }) => MovementRecord(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    fromSectionId: fromSectionId ?? this.fromSectionId,
    toSectionId: toSectionId ?? this.toSectionId,
    movedAt: movedAt ?? this.movedAt,
  );
  MovementRecord copyWithCompanion(MovementRecordsCompanion data) {
    return MovementRecord(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      fromSectionId: data.fromSectionId.present
          ? data.fromSectionId.value
          : this.fromSectionId,
      toSectionId: data.toSectionId.present
          ? data.toSectionId.value
          : this.toSectionId,
      movedAt: data.movedAt.present ? data.movedAt.value : this.movedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovementRecord(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('fromSectionId: $fromSectionId, ')
          ..write('toSectionId: $toSectionId, ')
          ..write('movedAt: $movedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, itemId, fromSectionId, toSectionId, movedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovementRecord &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.fromSectionId == this.fromSectionId &&
          other.toSectionId == this.toSectionId &&
          other.movedAt == this.movedAt);
}

class MovementRecordsCompanion extends UpdateCompanion<MovementRecord> {
  final Value<String> id;
  final Value<String> itemId;
  final Value<String> fromSectionId;
  final Value<String> toSectionId;
  final Value<DateTime> movedAt;
  final Value<int> rowid;
  const MovementRecordsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.fromSectionId = const Value.absent(),
    this.toSectionId = const Value.absent(),
    this.movedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MovementRecordsCompanion.insert({
    required String id,
    required String itemId,
    required String fromSectionId,
    required String toSectionId,
    this.movedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       itemId = Value(itemId),
       fromSectionId = Value(fromSectionId),
       toSectionId = Value(toSectionId);
  static Insertable<MovementRecord> custom({
    Expression<String>? id,
    Expression<String>? itemId,
    Expression<String>? fromSectionId,
    Expression<String>? toSectionId,
    Expression<DateTime>? movedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (fromSectionId != null) 'from_section_id': fromSectionId,
      if (toSectionId != null) 'to_section_id': toSectionId,
      if (movedAt != null) 'moved_at': movedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MovementRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? itemId,
    Value<String>? fromSectionId,
    Value<String>? toSectionId,
    Value<DateTime>? movedAt,
    Value<int>? rowid,
  }) {
    return MovementRecordsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      fromSectionId: fromSectionId ?? this.fromSectionId,
      toSectionId: toSectionId ?? this.toSectionId,
      movedAt: movedAt ?? this.movedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (fromSectionId.present) {
      map['from_section_id'] = Variable<String>(fromSectionId.value);
    }
    if (toSectionId.present) {
      map['to_section_id'] = Variable<String>(toSectionId.value);
    }
    if (movedAt.present) {
      map['moved_at'] = Variable<DateTime>(movedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovementRecordsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('fromSectionId: $fromSectionId, ')
          ..write('toSectionId: $toSectionId, ')
          ..write('movedAt: $movedAt, ')
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
  late final $WorkspacesTable workspaces = $WorkspacesTable(this);
  late final $RoomScansTable roomScans = $RoomScansTable(this);
  late final $StorageContainersTable storageContainers =
      $StorageContainersTable(this);
  late final $StorageSectionsTable storageSections = $StorageSectionsTable(
    this,
  );
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final $CheckoutRecordsTable checkoutRecords = $CheckoutRecordsTable(
    this,
  );
  late final $ScanCandidatesTable scanCandidates = $ScanCandidatesTable(this);
  late final $MovementRecordsTable movementRecords = $MovementRecordsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    persistenceSpikeItems,
    workspaces,
    roomScans,
    storageContainers,
    storageSections,
    inventoryItems,
    checkoutRecords,
    scanCandidates,
    movementRecords,
  ];
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
typedef $$WorkspacesTableCreateCompanionBuilder =
    WorkspacesCompanion Function({
      required String id,
      required String name,
      Value<String> description,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$WorkspacesTableUpdateCompanionBuilder =
    WorkspacesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$WorkspacesTableReferences
    extends BaseReferences<_$AppDatabase, $WorkspacesTable, Workspace> {
  $$WorkspacesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RoomScansTable, List<RoomScan>>
  _roomScansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roomScans,
    aliasName: 'workspaces__id__room_scans__workspace_id',
  );

  $$RoomScansTableProcessedTableManager get roomScansRefs {
    final manager = $$RoomScansTableTableManager(
      $_db,
      $_db.roomScans,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_roomScansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StorageContainersTable, List<StorageContainer>>
  _storageContainersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.storageContainers,
        aliasName: 'workspaces__id__storage_containers__workspace_id',
      );

  $$StorageContainersTableProcessedTableManager get storageContainersRefs {
    final manager = $$StorageContainersTableTableManager(
      $_db,
      $_db.storageContainers,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _storageContainersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InventoryItemsTable, List<InventoryItem>>
  _inventoryItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.inventoryItems,
    aliasName: 'workspaces__id__inventory_items__workspace_id',
  );

  $$InventoryItemsTableProcessedTableManager get inventoryItemsRefs {
    final manager = $$InventoryItemsTableTableManager(
      $_db,
      $_db.inventoryItems,
    ).filter((f) => f.workspaceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_inventoryItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkspacesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> roomScansRefs(
    Expression<bool> Function($$RoomScansTableFilterComposer f) f,
  ) {
    final $$RoomScansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roomScans,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomScansTableFilterComposer(
            $db: $db,
            $table: $db.roomScans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> storageContainersRefs(
    Expression<bool> Function($$StorageContainersTableFilterComposer f) f,
  ) {
    final $$StorageContainersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.storageContainers,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageContainersTableFilterComposer(
            $db: $db,
            $table: $db.storageContainers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inventoryItemsRefs(
    Expression<bool> Function($$InventoryItemsTableFilterComposer f) f,
  ) {
    final $$InventoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkspacesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkspacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> roomScansRefs<T extends Object>(
    Expression<T> Function($$RoomScansTableAnnotationComposer a) f,
  ) {
    final $$RoomScansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roomScans,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomScansTableAnnotationComposer(
            $db: $db,
            $table: $db.roomScans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> storageContainersRefs<T extends Object>(
    Expression<T> Function($$StorageContainersTableAnnotationComposer a) f,
  ) {
    final $$StorageContainersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.storageContainers,
          getReferencedColumn: (t) => t.workspaceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StorageContainersTableAnnotationComposer(
                $db: $db,
                $table: $db.storageContainers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> inventoryItemsRefs<T extends Object>(
    Expression<T> Function($$InventoryItemsTableAnnotationComposer a) f,
  ) {
    final $$InventoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.workspaceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkspacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkspacesTable,
          Workspace,
          $$WorkspacesTableFilterComposer,
          $$WorkspacesTableOrderingComposer,
          $$WorkspacesTableAnnotationComposer,
          $$WorkspacesTableCreateCompanionBuilder,
          $$WorkspacesTableUpdateCompanionBuilder,
          (Workspace, $$WorkspacesTableReferences),
          Workspace,
          PrefetchHooks Function({
            bool roomScansRefs,
            bool storageContainersRefs,
            bool inventoryItemsRefs,
          })
        > {
  $$WorkspacesTableTableManager(_$AppDatabase db, $WorkspacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkspacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkspacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkspacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkspacesCompanion(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkspacesCompanion.insert(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkspacesTable, Workspace>(table),
                  $$WorkspacesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                roomScansRefs = false,
                storageContainersRefs = false,
                inventoryItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (roomScansRefs) db.roomScans,
                    if (storageContainersRefs) db.storageContainers,
                    if (inventoryItemsRefs) db.inventoryItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (roomScansRefs)
                        await $_getPrefetchedData<
                          Workspace,
                          $WorkspacesTable,
                          RoomScan
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._roomScansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).roomScansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.workspaceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (storageContainersRefs)
                        await $_getPrefetchedData<
                          Workspace,
                          $WorkspacesTable,
                          StorageContainer
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._storageContainersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).storageContainersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.workspaceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (inventoryItemsRefs)
                        await $_getPrefetchedData<
                          Workspace,
                          $WorkspacesTable,
                          InventoryItem
                        >(
                          currentTable: table,
                          referencedTable: $$WorkspacesTableReferences
                              ._inventoryItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkspacesTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.workspaceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WorkspacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkspacesTable,
      Workspace,
      $$WorkspacesTableFilterComposer,
      $$WorkspacesTableOrderingComposer,
      $$WorkspacesTableAnnotationComposer,
      $$WorkspacesTableCreateCompanionBuilder,
      $$WorkspacesTableUpdateCompanionBuilder,
      (Workspace, $$WorkspacesTableReferences),
      Workspace,
      PrefetchHooks Function({
        bool roomScansRefs,
        bool storageContainersRefs,
        bool inventoryItemsRefs,
      })
    >;
typedef $$RoomScansTableCreateCompanionBuilder =
    RoomScansCompanion Function({
      required String id,
      required String workspaceId,
      required String source,
      Value<DateTime> capturedAt,
      Value<int> rowid,
    });
typedef $$RoomScansTableUpdateCompanionBuilder =
    RoomScansCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String> source,
      Value<DateTime> capturedAt,
      Value<int> rowid,
    });

final class $$RoomScansTableReferences
    extends BaseReferences<_$AppDatabase, $RoomScansTable, RoomScan> {
  $$RoomScansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) =>
      db.workspaces.createAlias('room_scans__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$StorageContainersTable, List<StorageContainer>>
  _storageContainersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.storageContainers,
        aliasName: 'room_scans__id__storage_containers__room_scan_id',
      );

  $$StorageContainersTableProcessedTableManager get storageContainersRefs {
    final manager = $$StorageContainersTableTableManager(
      $_db,
      $_db.storageContainers,
    ).filter((f) => f.roomScanId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _storageContainersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoomScansTableFilterComposer
    extends Composer<_$AppDatabase, $RoomScansTable> {
  $$RoomScansTableFilterComposer({
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

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> storageContainersRefs(
    Expression<bool> Function($$StorageContainersTableFilterComposer f) f,
  ) {
    final $$StorageContainersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.storageContainers,
      getReferencedColumn: (t) => t.roomScanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageContainersTableFilterComposer(
            $db: $db,
            $table: $db.storageContainers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoomScansTableOrderingComposer
    extends Composer<_$AppDatabase, $RoomScansTable> {
  $$RoomScansTableOrderingComposer({
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

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoomScansTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoomScansTable> {
  $$RoomScansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => column,
  );

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> storageContainersRefs<T extends Object>(
    Expression<T> Function($$StorageContainersTableAnnotationComposer a) f,
  ) {
    final $$StorageContainersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.storageContainers,
          getReferencedColumn: (t) => t.roomScanId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StorageContainersTableAnnotationComposer(
                $db: $db,
                $table: $db.storageContainers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RoomScansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoomScansTable,
          RoomScan,
          $$RoomScansTableFilterComposer,
          $$RoomScansTableOrderingComposer,
          $$RoomScansTableAnnotationComposer,
          $$RoomScansTableCreateCompanionBuilder,
          $$RoomScansTableUpdateCompanionBuilder,
          (RoomScan, $$RoomScansTableReferences),
          RoomScan,
          PrefetchHooks Function({bool workspaceId, bool storageContainersRefs})
        > {
  $$RoomScansTableTableManager(_$AppDatabase db, $RoomScansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoomScansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoomScansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoomScansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> capturedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoomScansCompanion(
                id: id,
                workspaceId: workspaceId,
                source: source,
                capturedAt: capturedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                required String source,
                Value<DateTime> capturedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoomScansCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                source: source,
                capturedAt: capturedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoomScansTable, RoomScan>(table),
                  $$RoomScansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({workspaceId = false, storageContainersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (storageContainersRefs) db.storageContainers,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workspaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workspaceId,
                                    referencedTable: $$RoomScansTableReferences
                                        ._workspaceIdTable(db),
                                    referencedColumn: $$RoomScansTableReferences
                                        ._workspaceIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (storageContainersRefs)
                        await $_getPrefetchedData<
                          RoomScan,
                          $RoomScansTable,
                          StorageContainer
                        >(
                          currentTable: table,
                          referencedTable: $$RoomScansTableReferences
                              ._storageContainersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoomScansTableReferences(
                                db,
                                table,
                                p0,
                              ).storageContainersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.roomScanId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RoomScansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoomScansTable,
      RoomScan,
      $$RoomScansTableFilterComposer,
      $$RoomScansTableOrderingComposer,
      $$RoomScansTableAnnotationComposer,
      $$RoomScansTableCreateCompanionBuilder,
      $$RoomScansTableUpdateCompanionBuilder,
      (RoomScan, $$RoomScansTableReferences),
      RoomScan,
      PrefetchHooks Function({bool workspaceId, bool storageContainersRefs})
    >;
typedef $$StorageContainersTableCreateCompanionBuilder =
    StorageContainersCompanion Function({
      required String id,
      required String workspaceId,
      Value<String?> roomScanId,
      required String name,
      required String type,
      Value<String?> layoutLabel,
      Value<bool> fromSampleScan,
      Value<int> rowid,
    });
typedef $$StorageContainersTableUpdateCompanionBuilder =
    StorageContainersCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String?> roomScanId,
      Value<String> name,
      Value<String> type,
      Value<String?> layoutLabel,
      Value<bool> fromSampleScan,
      Value<int> rowid,
    });

final class $$StorageContainersTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $StorageContainersTable,
          StorageContainer
        > {
  $$StorageContainersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) => db.workspaces
      .createAlias('storage_containers__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RoomScansTable _roomScanIdTable(_$AppDatabase db) => db.roomScans
      .createAlias('storage_containers__room_scan_id__room_scans__id');

  $$RoomScansTableProcessedTableManager? get roomScanId {
    final $_column = $_itemColumn<String>('room_scan_id');
    if ($_column == null) return null;
    final manager = $$RoomScansTableTableManager(
      $_db,
      $_db.roomScans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roomScanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$StorageSectionsTable, List<StorageSection>>
  _storageSectionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.storageSections,
    aliasName: 'storage_containers__id__storage_sections__container_id',
  );

  $$StorageSectionsTableProcessedTableManager get storageSectionsRefs {
    final manager = $$StorageSectionsTableTableManager(
      $_db,
      $_db.storageSections,
    ).filter((f) => f.containerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _storageSectionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StorageContainersTableFilterComposer
    extends Composer<_$AppDatabase, $StorageContainersTable> {
  $$StorageContainersTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get layoutLabel => $composableBuilder(
    column: $table.layoutLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get fromSampleScan => $composableBuilder(
    column: $table.fromSampleScan,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomScansTableFilterComposer get roomScanId {
    final $$RoomScansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomScanId,
      referencedTable: $db.roomScans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomScansTableFilterComposer(
            $db: $db,
            $table: $db.roomScans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> storageSectionsRefs(
    Expression<bool> Function($$StorageSectionsTableFilterComposer f) f,
  ) {
    final $$StorageSectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.containerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableFilterComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StorageContainersTableOrderingComposer
    extends Composer<_$AppDatabase, $StorageContainersTable> {
  $$StorageContainersTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get layoutLabel => $composableBuilder(
    column: $table.layoutLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get fromSampleScan => $composableBuilder(
    column: $table.fromSampleScan,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomScansTableOrderingComposer get roomScanId {
    final $$RoomScansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomScanId,
      referencedTable: $db.roomScans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomScansTableOrderingComposer(
            $db: $db,
            $table: $db.roomScans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StorageContainersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StorageContainersTable> {
  $$StorageContainersTableAnnotationComposer({
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get layoutLabel => $composableBuilder(
    column: $table.layoutLabel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get fromSampleScan => $composableBuilder(
    column: $table.fromSampleScan,
    builder: (column) => column,
  );

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomScansTableAnnotationComposer get roomScanId {
    final $$RoomScansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomScanId,
      referencedTable: $db.roomScans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomScansTableAnnotationComposer(
            $db: $db,
            $table: $db.roomScans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> storageSectionsRefs<T extends Object>(
    Expression<T> Function($$StorageSectionsTableAnnotationComposer a) f,
  ) {
    final $$StorageSectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.containerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StorageContainersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StorageContainersTable,
          StorageContainer,
          $$StorageContainersTableFilterComposer,
          $$StorageContainersTableOrderingComposer,
          $$StorageContainersTableAnnotationComposer,
          $$StorageContainersTableCreateCompanionBuilder,
          $$StorageContainersTableUpdateCompanionBuilder,
          (StorageContainer, $$StorageContainersTableReferences),
          StorageContainer,
          PrefetchHooks Function({
            bool workspaceId,
            bool roomScanId,
            bool storageSectionsRefs,
          })
        > {
  $$StorageContainersTableTableManager(
    _$AppDatabase db,
    $StorageContainersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StorageContainersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StorageContainersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StorageContainersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String?> roomScanId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> layoutLabel = const Value.absent(),
                Value<bool> fromSampleScan = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StorageContainersCompanion(
                id: id,
                workspaceId: workspaceId,
                roomScanId: roomScanId,
                name: name,
                type: type,
                layoutLabel: layoutLabel,
                fromSampleScan: fromSampleScan,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                Value<String?> roomScanId = const Value.absent(),
                required String name,
                required String type,
                Value<String?> layoutLabel = const Value.absent(),
                Value<bool> fromSampleScan = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StorageContainersCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                roomScanId: roomScanId,
                name: name,
                type: type,
                layoutLabel: layoutLabel,
                fromSampleScan: fromSampleScan,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StorageContainersTable, StorageContainer>(table),
                  $$StorageContainersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workspaceId = false,
                roomScanId = false,
                storageSectionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (storageSectionsRefs) db.storageSections,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workspaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workspaceId,
                                    referencedTable:
                                        $$StorageContainersTableReferences
                                            ._workspaceIdTable(db),
                                    referencedColumn:
                                        $$StorageContainersTableReferences
                                            ._workspaceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (roomScanId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.roomScanId,
                                    referencedTable:
                                        $$StorageContainersTableReferences
                                            ._roomScanIdTable(db),
                                    referencedColumn:
                                        $$StorageContainersTableReferences
                                            ._roomScanIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (storageSectionsRefs)
                        await $_getPrefetchedData<
                          StorageContainer,
                          $StorageContainersTable,
                          StorageSection
                        >(
                          currentTable: table,
                          referencedTable: $$StorageContainersTableReferences
                              ._storageSectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StorageContainersTableReferences(
                                db,
                                table,
                                p0,
                              ).storageSectionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.containerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StorageContainersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StorageContainersTable,
      StorageContainer,
      $$StorageContainersTableFilterComposer,
      $$StorageContainersTableOrderingComposer,
      $$StorageContainersTableAnnotationComposer,
      $$StorageContainersTableCreateCompanionBuilder,
      $$StorageContainersTableUpdateCompanionBuilder,
      (StorageContainer, $$StorageContainersTableReferences),
      StorageContainer,
      PrefetchHooks Function({
        bool workspaceId,
        bool roomScanId,
        bool storageSectionsRefs,
      })
    >;
typedef $$StorageSectionsTableCreateCompanionBuilder =
    StorageSectionsCompanion Function({
      required String id,
      required String containerId,
      required String name,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$StorageSectionsTableUpdateCompanionBuilder =
    StorageSectionsCompanion Function({
      Value<String> id,
      Value<String> containerId,
      Value<String> name,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$StorageSectionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $StorageSectionsTable, StorageSection> {
  $$StorageSectionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StorageContainersTable _containerIdTable(_$AppDatabase db) => db
      .storageContainers
      .createAlias('storage_sections__container_id__storage_containers__id');

  $$StorageContainersTableProcessedTableManager get containerId {
    final $_column = $_itemColumn<String>('container_id')!;

    final manager = $$StorageContainersTableTableManager(
      $_db,
      $_db.storageContainers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_containerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ScanCandidatesTable, List<ScanCandidate>>
  _scanCandidatesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.scanCandidates,
    aliasName: 'storage_sections__id__scan_candidates__section_id',
  );

  $$ScanCandidatesTableProcessedTableManager get scanCandidatesRefs {
    final manager = $$ScanCandidatesTableTableManager(
      $_db,
      $_db.scanCandidates,
    ).filter((f) => f.sectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_scanCandidatesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StorageSectionsTableFilterComposer
    extends Composer<_$AppDatabase, $StorageSectionsTable> {
  $$StorageSectionsTableFilterComposer({
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

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$StorageContainersTableFilterComposer get containerId {
    final $$StorageContainersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.containerId,
      referencedTable: $db.storageContainers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageContainersTableFilterComposer(
            $db: $db,
            $table: $db.storageContainers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> scanCandidatesRefs(
    Expression<bool> Function($$ScanCandidatesTableFilterComposer f) f,
  ) {
    final $$ScanCandidatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanCandidates,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanCandidatesTableFilterComposer(
            $db: $db,
            $table: $db.scanCandidates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StorageSectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StorageSectionsTable> {
  $$StorageSectionsTableOrderingComposer({
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

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$StorageContainersTableOrderingComposer get containerId {
    final $$StorageContainersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.containerId,
      referencedTable: $db.storageContainers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageContainersTableOrderingComposer(
            $db: $db,
            $table: $db.storageContainers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StorageSectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StorageSectionsTable> {
  $$StorageSectionsTableAnnotationComposer({
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

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$StorageContainersTableAnnotationComposer get containerId {
    final $$StorageContainersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.containerId,
          referencedTable: $db.storageContainers,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StorageContainersTableAnnotationComposer(
                $db: $db,
                $table: $db.storageContainers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> scanCandidatesRefs<T extends Object>(
    Expression<T> Function($$ScanCandidatesTableAnnotationComposer a) f,
  ) {
    final $$ScanCandidatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanCandidates,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanCandidatesTableAnnotationComposer(
            $db: $db,
            $table: $db.scanCandidates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StorageSectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StorageSectionsTable,
          StorageSection,
          $$StorageSectionsTableFilterComposer,
          $$StorageSectionsTableOrderingComposer,
          $$StorageSectionsTableAnnotationComposer,
          $$StorageSectionsTableCreateCompanionBuilder,
          $$StorageSectionsTableUpdateCompanionBuilder,
          (StorageSection, $$StorageSectionsTableReferences),
          StorageSection,
          PrefetchHooks Function({bool containerId, bool scanCandidatesRefs})
        > {
  $$StorageSectionsTableTableManager(
    _$AppDatabase db,
    $StorageSectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StorageSectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StorageSectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StorageSectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> containerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StorageSectionsCompanion(
                id: id,
                containerId: containerId,
                name: name,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String containerId,
                required String name,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => StorageSectionsCompanion.insert(
                id: id,
                containerId: containerId,
                name: name,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StorageSectionsTable, StorageSection>(table),
                  $$StorageSectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({containerId = false, scanCandidatesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (scanCandidatesRefs) db.scanCandidates,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (containerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.containerId,
                                    referencedTable:
                                        $$StorageSectionsTableReferences
                                            ._containerIdTable(db),
                                    referencedColumn:
                                        $$StorageSectionsTableReferences
                                            ._containerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (scanCandidatesRefs)
                        await $_getPrefetchedData<
                          StorageSection,
                          $StorageSectionsTable,
                          ScanCandidate
                        >(
                          currentTable: table,
                          referencedTable: $$StorageSectionsTableReferences
                              ._scanCandidatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StorageSectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).scanCandidatesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StorageSectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StorageSectionsTable,
      StorageSection,
      $$StorageSectionsTableFilterComposer,
      $$StorageSectionsTableOrderingComposer,
      $$StorageSectionsTableAnnotationComposer,
      $$StorageSectionsTableCreateCompanionBuilder,
      $$StorageSectionsTableUpdateCompanionBuilder,
      (StorageSection, $$StorageSectionsTableReferences),
      StorageSection,
      PrefetchHooks Function({bool containerId, bool scanCandidatesRefs})
    >;
typedef $$InventoryItemsTableCreateCompanionBuilder =
    InventoryItemsCompanion Function({
      required String id,
      required String workspaceId,
      required String name,
      Value<String> category,
      Value<String> model,
      Value<String> identifier,
      Value<String> status,
      required String homeSectionId,
      required String currentSectionId,
      Value<String?> sourceCandidateId,
      Value<DateTime> lastConfirmedAt,
      Value<int> rowid,
    });
typedef $$InventoryItemsTableUpdateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<String> id,
      Value<String> workspaceId,
      Value<String> name,
      Value<String> category,
      Value<String> model,
      Value<String> identifier,
      Value<String> status,
      Value<String> homeSectionId,
      Value<String> currentSectionId,
      Value<String?> sourceCandidateId,
      Value<DateTime> lastConfirmedAt,
      Value<int> rowid,
    });

final class $$InventoryItemsTableReferences
    extends BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem> {
  $$InventoryItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkspacesTable _workspaceIdTable(_$AppDatabase db) => db.workspaces
      .createAlias('inventory_items__workspace_id__workspaces__id');

  $$WorkspacesTableProcessedTableManager get workspaceId {
    final $_column = $_itemColumn<String>('workspace_id')!;

    final manager = $$WorkspacesTableTableManager(
      $_db,
      $_db.workspaces,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workspaceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StorageSectionsTable _homeSectionIdTable(_$AppDatabase db) => db
      .storageSections
      .createAlias('inventory_items__home_section_id__storage_sections__id');

  $$StorageSectionsTableProcessedTableManager get homeSectionId {
    final $_column = $_itemColumn<String>('home_section_id')!;

    final manager = $$StorageSectionsTableTableManager(
      $_db,
      $_db.storageSections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_homeSectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StorageSectionsTable _currentSectionIdTable(_$AppDatabase db) => db
      .storageSections
      .createAlias('inventory_items__current_section_id__storage_sections__id');

  $$StorageSectionsTableProcessedTableManager get currentSectionId {
    final $_column = $_itemColumn<String>('current_section_id')!;

    final manager = $$StorageSectionsTableTableManager(
      $_db,
      $_db.storageSections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_currentSectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CheckoutRecordsTable, List<CheckoutRecord>>
  _checkoutRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.checkoutRecords,
    aliasName: 'inventory_items__id__checkout_records__item_id',
  );

  $$CheckoutRecordsTableProcessedTableManager get checkoutRecordsRefs {
    final manager = $$CheckoutRecordsTableTableManager(
      $_db,
      $_db.checkoutRecords,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _checkoutRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MovementRecordsTable, List<MovementRecord>>
  _movementRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.movementRecords,
    aliasName: 'inventory_items__id__movement_records__item_id',
  );

  $$MovementRecordsTableProcessedTableManager get movementRecordsRefs {
    final manager = $$MovementRecordsTableTableManager(
      $_db,
      $_db.movementRecords,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _movementRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
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

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get identifier => $composableBuilder(
    column: $table.identifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceCandidateId => $composableBuilder(
    column: $table.sourceCandidateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastConfirmedAt => $composableBuilder(
    column: $table.lastConfirmedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkspacesTableFilterComposer get workspaceId {
    final $$WorkspacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableFilterComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableFilterComposer get homeSectionId {
    final $$StorageSectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableFilterComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableFilterComposer get currentSectionId {
    final $$StorageSectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableFilterComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> checkoutRecordsRefs(
    Expression<bool> Function($$CheckoutRecordsTableFilterComposer f) f,
  ) {
    final $$CheckoutRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkoutRecords,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckoutRecordsTableFilterComposer(
            $db: $db,
            $table: $db.checkoutRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movementRecordsRefs(
    Expression<bool> Function($$MovementRecordsTableFilterComposer f) f,
  ) {
    final $$MovementRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movementRecords,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementRecordsTableFilterComposer(
            $db: $db,
            $table: $db.movementRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
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

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get identifier => $composableBuilder(
    column: $table.identifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceCandidateId => $composableBuilder(
    column: $table.sourceCandidateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastConfirmedAt => $composableBuilder(
    column: $table.lastConfirmedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkspacesTableOrderingComposer get workspaceId {
    final $$WorkspacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableOrderingComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableOrderingComposer get homeSectionId {
    final $$StorageSectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableOrderingComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableOrderingComposer get currentSectionId {
    final $$StorageSectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableOrderingComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
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

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get identifier => $composableBuilder(
    column: $table.identifier,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get sourceCandidateId => $composableBuilder(
    column: $table.sourceCandidateId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastConfirmedAt => $composableBuilder(
    column: $table.lastConfirmedAt,
    builder: (column) => column,
  );

  $$WorkspacesTableAnnotationComposer get workspaceId {
    final $$WorkspacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workspaceId,
      referencedTable: $db.workspaces,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkspacesTableAnnotationComposer(
            $db: $db,
            $table: $db.workspaces,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableAnnotationComposer get homeSectionId {
    final $$StorageSectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableAnnotationComposer get currentSectionId {
    final $$StorageSectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> checkoutRecordsRefs<T extends Object>(
    Expression<T> Function($$CheckoutRecordsTableAnnotationComposer a) f,
  ) {
    final $$CheckoutRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkoutRecords,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckoutRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.checkoutRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movementRecordsRefs<T extends Object>(
    Expression<T> Function($$MovementRecordsTableAnnotationComposer a) f,
  ) {
    final $$MovementRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.movementRecords,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MovementRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.movementRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InventoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryItemsTable,
          InventoryItem,
          $$InventoryItemsTableFilterComposer,
          $$InventoryItemsTableOrderingComposer,
          $$InventoryItemsTableAnnotationComposer,
          $$InventoryItemsTableCreateCompanionBuilder,
          $$InventoryItemsTableUpdateCompanionBuilder,
          (InventoryItem, $$InventoryItemsTableReferences),
          InventoryItem,
          PrefetchHooks Function({
            bool workspaceId,
            bool homeSectionId,
            bool currentSectionId,
            bool checkoutRecordsRefs,
            bool movementRecordsRefs,
          })
        > {
  $$InventoryItemsTableTableManager(
    _$AppDatabase db,
    $InventoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workspaceId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String> identifier = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> homeSectionId = const Value.absent(),
                Value<String> currentSectionId = const Value.absent(),
                Value<String?> sourceCandidateId = const Value.absent(),
                Value<DateTime> lastConfirmedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion(
                id: id,
                workspaceId: workspaceId,
                name: name,
                category: category,
                model: model,
                identifier: identifier,
                status: status,
                homeSectionId: homeSectionId,
                currentSectionId: currentSectionId,
                sourceCandidateId: sourceCandidateId,
                lastConfirmedAt: lastConfirmedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workspaceId,
                required String name,
                Value<String> category = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String> identifier = const Value.absent(),
                Value<String> status = const Value.absent(),
                required String homeSectionId,
                required String currentSectionId,
                Value<String?> sourceCandidateId = const Value.absent(),
                Value<DateTime> lastConfirmedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion.insert(
                id: id,
                workspaceId: workspaceId,
                name: name,
                category: category,
                model: model,
                identifier: identifier,
                status: status,
                homeSectionId: homeSectionId,
                currentSectionId: currentSectionId,
                sourceCandidateId: sourceCandidateId,
                lastConfirmedAt: lastConfirmedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InventoryItemsTable, InventoryItem>(table),
                  $$InventoryItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workspaceId = false,
                homeSectionId = false,
                currentSectionId = false,
                checkoutRecordsRefs = false,
                movementRecordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (checkoutRecordsRefs) db.checkoutRecords,
                    if (movementRecordsRefs) db.movementRecords,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workspaceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workspaceId,
                                    referencedTable:
                                        $$InventoryItemsTableReferences
                                            ._workspaceIdTable(db),
                                    referencedColumn:
                                        $$InventoryItemsTableReferences
                                            ._workspaceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (homeSectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.homeSectionId,
                                    referencedTable:
                                        $$InventoryItemsTableReferences
                                            ._homeSectionIdTable(db),
                                    referencedColumn:
                                        $$InventoryItemsTableReferences
                                            ._homeSectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (currentSectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.currentSectionId,
                                    referencedTable:
                                        $$InventoryItemsTableReferences
                                            ._currentSectionIdTable(db),
                                    referencedColumn:
                                        $$InventoryItemsTableReferences
                                            ._currentSectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (checkoutRecordsRefs)
                        await $_getPrefetchedData<
                          InventoryItem,
                          $InventoryItemsTable,
                          CheckoutRecord
                        >(
                          currentTable: table,
                          referencedTable: $$InventoryItemsTableReferences
                              ._checkoutRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InventoryItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).checkoutRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (movementRecordsRefs)
                        await $_getPrefetchedData<
                          InventoryItem,
                          $InventoryItemsTable,
                          MovementRecord
                        >(
                          currentTable: table,
                          referencedTable: $$InventoryItemsTableReferences
                              ._movementRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InventoryItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).movementRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InventoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryItemsTable,
      InventoryItem,
      $$InventoryItemsTableFilterComposer,
      $$InventoryItemsTableOrderingComposer,
      $$InventoryItemsTableAnnotationComposer,
      $$InventoryItemsTableCreateCompanionBuilder,
      $$InventoryItemsTableUpdateCompanionBuilder,
      (InventoryItem, $$InventoryItemsTableReferences),
      InventoryItem,
      PrefetchHooks Function({
        bool workspaceId,
        bool homeSectionId,
        bool currentSectionId,
        bool checkoutRecordsRefs,
        bool movementRecordsRefs,
      })
    >;
typedef $$CheckoutRecordsTableCreateCompanionBuilder =
    CheckoutRecordsCompanion Function({
      required String id,
      required String itemId,
      required String borrower,
      required DateTime dueAt,
      Value<DateTime> checkedOutAt,
      Value<DateTime?> returnedAt,
      Value<String> condition,
      Value<String> notes,
      Value<int> rowid,
    });
typedef $$CheckoutRecordsTableUpdateCompanionBuilder =
    CheckoutRecordsCompanion Function({
      Value<String> id,
      Value<String> itemId,
      Value<String> borrower,
      Value<DateTime> dueAt,
      Value<DateTime> checkedOutAt,
      Value<DateTime?> returnedAt,
      Value<String> condition,
      Value<String> notes,
      Value<int> rowid,
    });

final class $$CheckoutRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $CheckoutRecordsTable, CheckoutRecord> {
  $$CheckoutRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InventoryItemsTable _itemIdTable(_$AppDatabase db) => db
      .inventoryItems
      .createAlias('checkout_records__item_id__inventory_items__id');

  $$InventoryItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$InventoryItemsTableTableManager(
      $_db,
      $_db.inventoryItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CheckoutRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $CheckoutRecordsTable> {
  $$CheckoutRecordsTableFilterComposer({
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

  ColumnFilters<String> get borrower => $composableBuilder(
    column: $table.borrower,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkedOutAt => $composableBuilder(
    column: $table.checkedOutAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$InventoryItemsTableFilterComposer get itemId {
    final $$InventoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckoutRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckoutRecordsTable> {
  $$CheckoutRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get borrower => $composableBuilder(
    column: $table.borrower,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkedOutAt => $composableBuilder(
    column: $table.checkedOutAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$InventoryItemsTableOrderingComposer get itemId {
    final $$InventoryItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableOrderingComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckoutRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckoutRecordsTable> {
  $$CheckoutRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get borrower =>
      $composableBuilder(column: $table.borrower, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<DateTime> get checkedOutAt => $composableBuilder(
    column: $table.checkedOutAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$InventoryItemsTableAnnotationComposer get itemId {
    final $$InventoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckoutRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CheckoutRecordsTable,
          CheckoutRecord,
          $$CheckoutRecordsTableFilterComposer,
          $$CheckoutRecordsTableOrderingComposer,
          $$CheckoutRecordsTableAnnotationComposer,
          $$CheckoutRecordsTableCreateCompanionBuilder,
          $$CheckoutRecordsTableUpdateCompanionBuilder,
          (CheckoutRecord, $$CheckoutRecordsTableReferences),
          CheckoutRecord,
          PrefetchHooks Function({bool itemId})
        > {
  $$CheckoutRecordsTableTableManager(
    _$AppDatabase db,
    $CheckoutRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckoutRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckoutRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckoutRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> borrower = const Value.absent(),
                Value<DateTime> dueAt = const Value.absent(),
                Value<DateTime> checkedOutAt = const Value.absent(),
                Value<DateTime?> returnedAt = const Value.absent(),
                Value<String> condition = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckoutRecordsCompanion(
                id: id,
                itemId: itemId,
                borrower: borrower,
                dueAt: dueAt,
                checkedOutAt: checkedOutAt,
                returnedAt: returnedAt,
                condition: condition,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String itemId,
                required String borrower,
                required DateTime dueAt,
                Value<DateTime> checkedOutAt = const Value.absent(),
                Value<DateTime?> returnedAt = const Value.absent(),
                Value<String> condition = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckoutRecordsCompanion.insert(
                id: id,
                itemId: itemId,
                borrower: borrower,
                dueAt: dueAt,
                checkedOutAt: checkedOutAt,
                returnedAt: returnedAt,
                condition: condition,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CheckoutRecordsTable, CheckoutRecord>(table),
                  $$CheckoutRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (itemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.itemId,
                                referencedTable:
                                    $$CheckoutRecordsTableReferences
                                        ._itemIdTable(db),
                                referencedColumn:
                                    $$CheckoutRecordsTableReferences
                                        ._itemIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CheckoutRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CheckoutRecordsTable,
      CheckoutRecord,
      $$CheckoutRecordsTableFilterComposer,
      $$CheckoutRecordsTableOrderingComposer,
      $$CheckoutRecordsTableAnnotationComposer,
      $$CheckoutRecordsTableCreateCompanionBuilder,
      $$CheckoutRecordsTableUpdateCompanionBuilder,
      (CheckoutRecord, $$CheckoutRecordsTableReferences),
      CheckoutRecord,
      PrefetchHooks Function({bool itemId})
    >;
typedef $$ScanCandidatesTableCreateCompanionBuilder =
    ScanCandidatesCompanion Function({
      required String id,
      required String sectionId,
      required String name,
      Value<String> category,
      Value<String> model,
      Value<String> identifier,
      Value<double> confidence,
      Value<String> state,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ScanCandidatesTableUpdateCompanionBuilder =
    ScanCandidatesCompanion Function({
      Value<String> id,
      Value<String> sectionId,
      Value<String> name,
      Value<String> category,
      Value<String> model,
      Value<String> identifier,
      Value<double> confidence,
      Value<String> state,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ScanCandidatesTableReferences
    extends BaseReferences<_$AppDatabase, $ScanCandidatesTable, ScanCandidate> {
  $$ScanCandidatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StorageSectionsTable _sectionIdTable(_$AppDatabase db) => db
      .storageSections
      .createAlias('scan_candidates__section_id__storage_sections__id');

  $$StorageSectionsTableProcessedTableManager get sectionId {
    final $_column = $_itemColumn<String>('section_id')!;

    final manager = $$StorageSectionsTableTableManager(
      $_db,
      $_db.storageSections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScanCandidatesTableFilterComposer
    extends Composer<_$AppDatabase, $ScanCandidatesTable> {
  $$ScanCandidatesTableFilterComposer({
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

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get identifier => $composableBuilder(
    column: $table.identifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$StorageSectionsTableFilterComposer get sectionId {
    final $$StorageSectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableFilterComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanCandidatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanCandidatesTable> {
  $$ScanCandidatesTableOrderingComposer({
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

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get identifier => $composableBuilder(
    column: $table.identifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$StorageSectionsTableOrderingComposer get sectionId {
    final $$StorageSectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableOrderingComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanCandidatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanCandidatesTable> {
  $$ScanCandidatesTableAnnotationComposer({
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

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get identifier => $composableBuilder(
    column: $table.identifier,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StorageSectionsTableAnnotationComposer get sectionId {
    final $$StorageSectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanCandidatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanCandidatesTable,
          ScanCandidate,
          $$ScanCandidatesTableFilterComposer,
          $$ScanCandidatesTableOrderingComposer,
          $$ScanCandidatesTableAnnotationComposer,
          $$ScanCandidatesTableCreateCompanionBuilder,
          $$ScanCandidatesTableUpdateCompanionBuilder,
          (ScanCandidate, $$ScanCandidatesTableReferences),
          ScanCandidate,
          PrefetchHooks Function({bool sectionId})
        > {
  $$ScanCandidatesTableTableManager(
    _$AppDatabase db,
    $ScanCandidatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanCandidatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanCandidatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanCandidatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sectionId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String> identifier = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScanCandidatesCompanion(
                id: id,
                sectionId: sectionId,
                name: name,
                category: category,
                model: model,
                identifier: identifier,
                confidence: confidence,
                state: state,
                source: source,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sectionId,
                required String name,
                Value<String> category = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String> identifier = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScanCandidatesCompanion.insert(
                id: id,
                sectionId: sectionId,
                name: name,
                category: category,
                model: model,
                identifier: identifier,
                confidence: confidence,
                state: state,
                source: source,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ScanCandidatesTable, ScanCandidate>(table),
                  $$ScanCandidatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sectionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sectionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sectionId,
                                referencedTable: $$ScanCandidatesTableReferences
                                    ._sectionIdTable(db),
                                referencedColumn:
                                    $$ScanCandidatesTableReferences
                                        ._sectionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScanCandidatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanCandidatesTable,
      ScanCandidate,
      $$ScanCandidatesTableFilterComposer,
      $$ScanCandidatesTableOrderingComposer,
      $$ScanCandidatesTableAnnotationComposer,
      $$ScanCandidatesTableCreateCompanionBuilder,
      $$ScanCandidatesTableUpdateCompanionBuilder,
      (ScanCandidate, $$ScanCandidatesTableReferences),
      ScanCandidate,
      PrefetchHooks Function({bool sectionId})
    >;
typedef $$MovementRecordsTableCreateCompanionBuilder =
    MovementRecordsCompanion Function({
      required String id,
      required String itemId,
      required String fromSectionId,
      required String toSectionId,
      Value<DateTime> movedAt,
      Value<int> rowid,
    });
typedef $$MovementRecordsTableUpdateCompanionBuilder =
    MovementRecordsCompanion Function({
      Value<String> id,
      Value<String> itemId,
      Value<String> fromSectionId,
      Value<String> toSectionId,
      Value<DateTime> movedAt,
      Value<int> rowid,
    });

final class $$MovementRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $MovementRecordsTable, MovementRecord> {
  $$MovementRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InventoryItemsTable _itemIdTable(_$AppDatabase db) => db
      .inventoryItems
      .createAlias('movement_records__item_id__inventory_items__id');

  $$InventoryItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$InventoryItemsTableTableManager(
      $_db,
      $_db.inventoryItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StorageSectionsTable _fromSectionIdTable(_$AppDatabase db) => db
      .storageSections
      .createAlias('movement_records__from_section_id__storage_sections__id');

  $$StorageSectionsTableProcessedTableManager get fromSectionId {
    final $_column = $_itemColumn<String>('from_section_id')!;

    final manager = $$StorageSectionsTableTableManager(
      $_db,
      $_db.storageSections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromSectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StorageSectionsTable _toSectionIdTable(_$AppDatabase db) => db
      .storageSections
      .createAlias('movement_records__to_section_id__storage_sections__id');

  $$StorageSectionsTableProcessedTableManager get toSectionId {
    final $_column = $_itemColumn<String>('to_section_id')!;

    final manager = $$StorageSectionsTableTableManager(
      $_db,
      $_db.storageSections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toSectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MovementRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $MovementRecordsTable> {
  $$MovementRecordsTableFilterComposer({
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

  ColumnFilters<DateTime> get movedAt => $composableBuilder(
    column: $table.movedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InventoryItemsTableFilterComposer get itemId {
    final $$InventoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableFilterComposer get fromSectionId {
    final $$StorageSectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableFilterComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableFilterComposer get toSectionId {
    final $$StorageSectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableFilterComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $MovementRecordsTable> {
  $$MovementRecordsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get movedAt => $composableBuilder(
    column: $table.movedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InventoryItemsTableOrderingComposer get itemId {
    final $$InventoryItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableOrderingComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableOrderingComposer get fromSectionId {
    final $$StorageSectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableOrderingComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableOrderingComposer get toSectionId {
    final $$StorageSectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableOrderingComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovementRecordsTable> {
  $$MovementRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get movedAt =>
      $composableBuilder(column: $table.movedAt, builder: (column) => column);

  $$InventoryItemsTableAnnotationComposer get itemId {
    final $$InventoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableAnnotationComposer get fromSectionId {
    final $$StorageSectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StorageSectionsTableAnnotationComposer get toSectionId {
    final $$StorageSectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toSectionId,
      referencedTable: $db.storageSections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StorageSectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.storageSections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovementRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovementRecordsTable,
          MovementRecord,
          $$MovementRecordsTableFilterComposer,
          $$MovementRecordsTableOrderingComposer,
          $$MovementRecordsTableAnnotationComposer,
          $$MovementRecordsTableCreateCompanionBuilder,
          $$MovementRecordsTableUpdateCompanionBuilder,
          (MovementRecord, $$MovementRecordsTableReferences),
          MovementRecord,
          PrefetchHooks Function({
            bool itemId,
            bool fromSectionId,
            bool toSectionId,
          })
        > {
  $$MovementRecordsTableTableManager(
    _$AppDatabase db,
    $MovementRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovementRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovementRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovementRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> fromSectionId = const Value.absent(),
                Value<String> toSectionId = const Value.absent(),
                Value<DateTime> movedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MovementRecordsCompanion(
                id: id,
                itemId: itemId,
                fromSectionId: fromSectionId,
                toSectionId: toSectionId,
                movedAt: movedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String itemId,
                required String fromSectionId,
                required String toSectionId,
                Value<DateTime> movedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MovementRecordsCompanion.insert(
                id: id,
                itemId: itemId,
                fromSectionId: fromSectionId,
                toSectionId: toSectionId,
                movedAt: movedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MovementRecordsTable, MovementRecord>(table),
                  $$MovementRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({itemId = false, fromSectionId = false, toSectionId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (itemId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.itemId,
                                    referencedTable:
                                        $$MovementRecordsTableReferences
                                            ._itemIdTable(db),
                                    referencedColumn:
                                        $$MovementRecordsTableReferences
                                            ._itemIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (fromSectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fromSectionId,
                                    referencedTable:
                                        $$MovementRecordsTableReferences
                                            ._fromSectionIdTable(db),
                                    referencedColumn:
                                        $$MovementRecordsTableReferences
                                            ._fromSectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (toSectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.toSectionId,
                                    referencedTable:
                                        $$MovementRecordsTableReferences
                                            ._toSectionIdTable(db),
                                    referencedColumn:
                                        $$MovementRecordsTableReferences
                                            ._toSectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$MovementRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovementRecordsTable,
      MovementRecord,
      $$MovementRecordsTableFilterComposer,
      $$MovementRecordsTableOrderingComposer,
      $$MovementRecordsTableAnnotationComposer,
      $$MovementRecordsTableCreateCompanionBuilder,
      $$MovementRecordsTableUpdateCompanionBuilder,
      (MovementRecord, $$MovementRecordsTableReferences),
      MovementRecord,
      PrefetchHooks Function({
        bool itemId,
        bool fromSectionId,
        bool toSectionId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PersistenceSpikeItemsTableTableManager get persistenceSpikeItems =>
      $$PersistenceSpikeItemsTableTableManager(_db, _db.persistenceSpikeItems);
  $$WorkspacesTableTableManager get workspaces =>
      $$WorkspacesTableTableManager(_db, _db.workspaces);
  $$RoomScansTableTableManager get roomScans =>
      $$RoomScansTableTableManager(_db, _db.roomScans);
  $$StorageContainersTableTableManager get storageContainers =>
      $$StorageContainersTableTableManager(_db, _db.storageContainers);
  $$StorageSectionsTableTableManager get storageSections =>
      $$StorageSectionsTableTableManager(_db, _db.storageSections);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
  $$CheckoutRecordsTableTableManager get checkoutRecords =>
      $$CheckoutRecordsTableTableManager(_db, _db.checkoutRecords);
  $$ScanCandidatesTableTableManager get scanCandidates =>
      $$ScanCandidatesTableTableManager(_db, _db.scanCandidates);
  $$MovementRecordsTableTableManager get movementRecords =>
      $$MovementRecordsTableTableManager(_db, _db.movementRecords);
}
