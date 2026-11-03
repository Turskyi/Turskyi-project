// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_database.dart';

// ignore_for_file: type=lint
class $ProjectRankingsTableTable extends ProjectRankingsTable
    with TableInfo<$ProjectRankingsTableTable, ProjectRankingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectRankingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iosMeta = const VerificationMeta('ios');
  @override
  late final GeneratedColumn<int> ios = GeneratedColumn<int>(
    'ios',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _androidMeta = const VerificationMeta(
    'android',
  );
  @override
  late final GeneratedColumn<int> android = GeneratedColumn<int>(
    'android',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _webMeta = const VerificationMeta('web');
  @override
  late final GeneratedColumn<int> web = GeneratedColumn<int>(
    'web',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    total,
    ios,
    android,
    web,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'project_rankings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProjectRankingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('ios')) {
      context.handle(
        _iosMeta,
        ios.isAcceptableOrUnknown(data['ios']!, _iosMeta),
      );
    } else if (isInserting) {
      context.missing(_iosMeta);
    }
    if (data.containsKey('android')) {
      context.handle(
        _androidMeta,
        android.isAcceptableOrUnknown(data['android']!, _androidMeta),
      );
    } else if (isInserting) {
      context.missing(_androidMeta);
    }
    if (data.containsKey('web')) {
      context.handle(
        _webMeta,
        web.isAcceptableOrUnknown(data['web']!, _webMeta),
      );
    } else if (isInserting) {
      context.missing(_webMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProjectRankingsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectRankingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      ios: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ios'],
      )!,
      android: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}android'],
      )!,
      web: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}web'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProjectRankingsTableTable createAlias(String alias) {
    return $ProjectRankingsTableTable(attachedDatabase, alias);
  }
}

class ProjectRankingsTableData extends DataClass
    implements Insertable<ProjectRankingsTableData> {
  final String id;
  final int total;
  final int ios;
  final int android;
  final int web;
  final DateTime updatedAt;
  const ProjectRankingsTableData({
    required this.id,
    required this.total,
    required this.ios,
    required this.android,
    required this.web,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['total'] = Variable<int>(total);
    map['ios'] = Variable<int>(ios);
    map['android'] = Variable<int>(android);
    map['web'] = Variable<int>(web);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProjectRankingsTableCompanion toCompanion(bool nullToAbsent) {
    return ProjectRankingsTableCompanion(
      id: Value(id),
      total: Value(total),
      ios: Value(ios),
      android: Value(android),
      web: Value(web),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProjectRankingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectRankingsTableData(
      id: serializer.fromJson<String>(json['id']),
      total: serializer.fromJson<int>(json['total']),
      ios: serializer.fromJson<int>(json['ios']),
      android: serializer.fromJson<int>(json['android']),
      web: serializer.fromJson<int>(json['web']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'total': serializer.toJson<int>(total),
      'ios': serializer.toJson<int>(ios),
      'android': serializer.toJson<int>(android),
      'web': serializer.toJson<int>(web),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProjectRankingsTableData copyWith({
    String? id,
    int? total,
    int? ios,
    int? android,
    int? web,
    DateTime? updatedAt,
  }) => ProjectRankingsTableData(
    id: id ?? this.id,
    total: total ?? this.total,
    ios: ios ?? this.ios,
    android: android ?? this.android,
    web: web ?? this.web,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProjectRankingsTableData copyWithCompanion(
    ProjectRankingsTableCompanion data,
  ) {
    return ProjectRankingsTableData(
      id: data.id.present ? data.id.value : this.id,
      total: data.total.present ? data.total.value : this.total,
      ios: data.ios.present ? data.ios.value : this.ios,
      android: data.android.present ? data.android.value : this.android,
      web: data.web.present ? data.web.value : this.web,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProjectRankingsTableData(')
          ..write('id: $id, ')
          ..write('total: $total, ')
          ..write('ios: $ios, ')
          ..write('android: $android, ')
          ..write('web: $web, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, total, ios, android, web, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectRankingsTableData &&
          other.id == this.id &&
          other.total == this.total &&
          other.ios == this.ios &&
          other.android == this.android &&
          other.web == this.web &&
          other.updatedAt == this.updatedAt);
}

class ProjectRankingsTableCompanion
    extends UpdateCompanion<ProjectRankingsTableData> {
  final Value<String> id;
  final Value<int> total;
  final Value<int> ios;
  final Value<int> android;
  final Value<int> web;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProjectRankingsTableCompanion({
    this.id = const Value.absent(),
    this.total = const Value.absent(),
    this.ios = const Value.absent(),
    this.android = const Value.absent(),
    this.web = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectRankingsTableCompanion.insert({
    required String id,
    required int total,
    required int ios,
    required int android,
    required int web,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       total = Value(total),
       ios = Value(ios),
       android = Value(android),
       web = Value(web),
       updatedAt = Value(updatedAt);
  static Insertable<ProjectRankingsTableData> custom({
    Expression<String>? id,
    Expression<int>? total,
    Expression<int>? ios,
    Expression<int>? android,
    Expression<int>? web,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (total != null) 'total': total,
      if (ios != null) 'ios': ios,
      if (android != null) 'android': android,
      if (web != null) 'web': web,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectRankingsTableCompanion copyWith({
    Value<String>? id,
    Value<int>? total,
    Value<int>? ios,
    Value<int>? android,
    Value<int>? web,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProjectRankingsTableCompanion(
      id: id ?? this.id,
      total: total ?? this.total,
      ios: ios ?? this.ios,
      android: android ?? this.android,
      web: web ?? this.web,
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
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (ios.present) {
      map['ios'] = Variable<int>(ios.value);
    }
    if (android.present) {
      map['android'] = Variable<int>(android.value);
    }
    if (web.present) {
      map['web'] = Variable<int>(web.value);
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
    return (StringBuffer('ProjectRankingsTableCompanion(')
          ..write('id: $id, ')
          ..write('total: $total, ')
          ..write('ios: $ios, ')
          ..write('android: $android, ')
          ..write('web: $web, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RankingMetadataTableTable extends RankingMetadataTable
    with TableInfo<$RankingMetadataTableTable, RankingMetadataTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RankingMetadataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ranking_metadata_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RankingMetadataTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  RankingMetadataTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RankingMetadataTableData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $RankingMetadataTableTable createAlias(String alias) {
    return $RankingMetadataTableTable(attachedDatabase, alias);
  }
}

class RankingMetadataTableData extends DataClass
    implements Insertable<RankingMetadataTableData> {
  final String key;
  final String value;
  const RankingMetadataTableData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  RankingMetadataTableCompanion toCompanion(bool nullToAbsent) {
    return RankingMetadataTableCompanion(key: Value(key), value: Value(value));
  }

  factory RankingMetadataTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RankingMetadataTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  RankingMetadataTableData copyWith({String? key, String? value}) =>
      RankingMetadataTableData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  RankingMetadataTableData copyWithCompanion(
    RankingMetadataTableCompanion data,
  ) {
    return RankingMetadataTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RankingMetadataTableData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RankingMetadataTableData &&
          other.key == this.key &&
          other.value == this.value);
}

class RankingMetadataTableCompanion
    extends UpdateCompanion<RankingMetadataTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const RankingMetadataTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RankingMetadataTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<RankingMetadataTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RankingMetadataTableCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return RankingMetadataTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RankingMetadataTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$RankingDatabase extends GeneratedDatabase {
  _$RankingDatabase(QueryExecutor e) : super(e);
  $RankingDatabaseManager get managers => $RankingDatabaseManager(this);
  late final $ProjectRankingsTableTable projectRankingsTable =
      $ProjectRankingsTableTable(this);
  late final $RankingMetadataTableTable rankingMetadataTable =
      $RankingMetadataTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projectRankingsTable,
    rankingMetadataTable,
  ];
}

typedef $$ProjectRankingsTableTableCreateCompanionBuilder =
    ProjectRankingsTableCompanion Function({
      required String id,
      required int total,
      required int ios,
      required int android,
      required int web,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProjectRankingsTableTableUpdateCompanionBuilder =
    ProjectRankingsTableCompanion Function({
      Value<String> id,
      Value<int> total,
      Value<int> ios,
      Value<int> android,
      Value<int> web,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ProjectRankingsTableTableFilterComposer
    extends Composer<_$RankingDatabase, $ProjectRankingsTableTable> {
  $$ProjectRankingsTableTableFilterComposer({
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

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ios => $composableBuilder(
    column: $table.ios,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get android => $composableBuilder(
    column: $table.android,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get web => $composableBuilder(
    column: $table.web,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProjectRankingsTableTableOrderingComposer
    extends Composer<_$RankingDatabase, $ProjectRankingsTableTable> {
  $$ProjectRankingsTableTableOrderingComposer({
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

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ios => $composableBuilder(
    column: $table.ios,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get android => $composableBuilder(
    column: $table.android,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get web => $composableBuilder(
    column: $table.web,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProjectRankingsTableTableAnnotationComposer
    extends Composer<_$RankingDatabase, $ProjectRankingsTableTable> {
  $$ProjectRankingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<int> get ios =>
      $composableBuilder(column: $table.ios, builder: (column) => column);

  GeneratedColumn<int> get android =>
      $composableBuilder(column: $table.android, builder: (column) => column);

  GeneratedColumn<int> get web =>
      $composableBuilder(column: $table.web, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProjectRankingsTableTableTableManager
    extends
        RootTableManager<
          _$RankingDatabase,
          $ProjectRankingsTableTable,
          ProjectRankingsTableData,
          $$ProjectRankingsTableTableFilterComposer,
          $$ProjectRankingsTableTableOrderingComposer,
          $$ProjectRankingsTableTableAnnotationComposer,
          $$ProjectRankingsTableTableCreateCompanionBuilder,
          $$ProjectRankingsTableTableUpdateCompanionBuilder,
          (
            ProjectRankingsTableData,
            BaseReferences<
              _$RankingDatabase,
              $ProjectRankingsTableTable,
              ProjectRankingsTableData
            >,
          ),
          ProjectRankingsTableData,
          PrefetchHooks Function()
        > {
  $$ProjectRankingsTableTableTableManager(
    _$RankingDatabase db,
    $ProjectRankingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectRankingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectRankingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProjectRankingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<int> ios = const Value.absent(),
                Value<int> android = const Value.absent(),
                Value<int> web = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectRankingsTableCompanion(
                id: id,
                total: total,
                ios: ios,
                android: android,
                web: web,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int total,
                required int ios,
                required int android,
                required int web,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProjectRankingsTableCompanion.insert(
                id: id,
                total: total,
                ios: ios,
                android: android,
                web: web,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ProjectRankingsTableTable,
                    ProjectRankingsTableData
                  >(table),
                  BaseReferences<
                    _$RankingDatabase,
                    $ProjectRankingsTableTable,
                    ProjectRankingsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProjectRankingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$RankingDatabase,
      $ProjectRankingsTableTable,
      ProjectRankingsTableData,
      $$ProjectRankingsTableTableFilterComposer,
      $$ProjectRankingsTableTableOrderingComposer,
      $$ProjectRankingsTableTableAnnotationComposer,
      $$ProjectRankingsTableTableCreateCompanionBuilder,
      $$ProjectRankingsTableTableUpdateCompanionBuilder,
      (
        ProjectRankingsTableData,
        BaseReferences<
          _$RankingDatabase,
          $ProjectRankingsTableTable,
          ProjectRankingsTableData
        >,
      ),
      ProjectRankingsTableData,
      PrefetchHooks Function()
    >;
typedef $$RankingMetadataTableTableCreateCompanionBuilder =
    RankingMetadataTableCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$RankingMetadataTableTableUpdateCompanionBuilder =
    RankingMetadataTableCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$RankingMetadataTableTableFilterComposer
    extends Composer<_$RankingDatabase, $RankingMetadataTableTable> {
  $$RankingMetadataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RankingMetadataTableTableOrderingComposer
    extends Composer<_$RankingDatabase, $RankingMetadataTableTable> {
  $$RankingMetadataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RankingMetadataTableTableAnnotationComposer
    extends Composer<_$RankingDatabase, $RankingMetadataTableTable> {
  $$RankingMetadataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$RankingMetadataTableTableTableManager
    extends
        RootTableManager<
          _$RankingDatabase,
          $RankingMetadataTableTable,
          RankingMetadataTableData,
          $$RankingMetadataTableTableFilterComposer,
          $$RankingMetadataTableTableOrderingComposer,
          $$RankingMetadataTableTableAnnotationComposer,
          $$RankingMetadataTableTableCreateCompanionBuilder,
          $$RankingMetadataTableTableUpdateCompanionBuilder,
          (
            RankingMetadataTableData,
            BaseReferences<
              _$RankingDatabase,
              $RankingMetadataTableTable,
              RankingMetadataTableData
            >,
          ),
          RankingMetadataTableData,
          PrefetchHooks Function()
        > {
  $$RankingMetadataTableTableTableManager(
    _$RankingDatabase db,
    $RankingMetadataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RankingMetadataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RankingMetadataTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RankingMetadataTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RankingMetadataTableCompanion(
                key: key,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => RankingMetadataTableCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $RankingMetadataTableTable,
                    RankingMetadataTableData
                  >(table),
                  BaseReferences<
                    _$RankingDatabase,
                    $RankingMetadataTableTable,
                    RankingMetadataTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RankingMetadataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$RankingDatabase,
      $RankingMetadataTableTable,
      RankingMetadataTableData,
      $$RankingMetadataTableTableFilterComposer,
      $$RankingMetadataTableTableOrderingComposer,
      $$RankingMetadataTableTableAnnotationComposer,
      $$RankingMetadataTableTableCreateCompanionBuilder,
      $$RankingMetadataTableTableUpdateCompanionBuilder,
      (
        RankingMetadataTableData,
        BaseReferences<
          _$RankingDatabase,
          $RankingMetadataTableTable,
          RankingMetadataTableData
        >,
      ),
      RankingMetadataTableData,
      PrefetchHooks Function()
    >;

class $RankingDatabaseManager {
  final _$RankingDatabase _db;
  $RankingDatabaseManager(this._db);
  $$ProjectRankingsTableTableTableManager get projectRankingsTable =>
      $$ProjectRankingsTableTableTableManager(_db, _db.projectRankingsTable);
  $$RankingMetadataTableTableTableManager get rankingMetadataTable =>
      $$RankingMetadataTableTableTableManager(_db, _db.rankingMetadataTable);
}
