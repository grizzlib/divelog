// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DivesTable extends Dives with TableInfo<$DivesTable, Dive> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DivesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationNameMeta = const VerificationMeta(
    'locationName',
  );
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
    'location_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxDepthFtMeta = const VerificationMeta(
    'maxDepthFt',
  );
  @override
  late final GeneratedColumn<int> maxDepthFt = GeneratedColumn<int>(
    'max_depth_ft',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bottomTimeMinMeta = const VerificationMeta(
    'bottomTimeMin',
  );
  @override
  late final GeneratedColumn<int> bottomTimeMin = GeneratedColumn<int>(
    'bottom_time_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startPressurePsiMeta = const VerificationMeta(
    'startPressurePsi',
  );
  @override
  late final GeneratedColumn<int> startPressurePsi = GeneratedColumn<int>(
    'start_pressure_psi',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endPressurePsiMeta = const VerificationMeta(
    'endPressurePsi',
  );
  @override
  late final GeneratedColumn<int> endPressurePsi = GeneratedColumn<int>(
    'end_pressure_psi',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    locationName,
    maxDepthFt,
    bottomTimeMin,
    startPressurePsi,
    endPressurePsi,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dives';
  @override
  VerificationContext validateIntegrity(
    Insertable<Dive> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('location_name')) {
      context.handle(
        _locationNameMeta,
        locationName.isAcceptableOrUnknown(
          data['location_name']!,
          _locationNameMeta,
        ),
      );
    }
    if (data.containsKey('max_depth_ft')) {
      context.handle(
        _maxDepthFtMeta,
        maxDepthFt.isAcceptableOrUnknown(
          data['max_depth_ft']!,
          _maxDepthFtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxDepthFtMeta);
    }
    if (data.containsKey('bottom_time_min')) {
      context.handle(
        _bottomTimeMinMeta,
        bottomTimeMin.isAcceptableOrUnknown(
          data['bottom_time_min']!,
          _bottomTimeMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bottomTimeMinMeta);
    }
    if (data.containsKey('start_pressure_psi')) {
      context.handle(
        _startPressurePsiMeta,
        startPressurePsi.isAcceptableOrUnknown(
          data['start_pressure_psi']!,
          _startPressurePsiMeta,
        ),
      );
    }
    if (data.containsKey('end_pressure_psi')) {
      context.handle(
        _endPressurePsiMeta,
        endPressurePsi.isAcceptableOrUnknown(
          data['end_pressure_psi']!,
          _endPressurePsiMeta,
        ),
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
  Dive map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dive(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      locationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_name'],
      ),
      maxDepthFt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_depth_ft'],
      )!,
      bottomTimeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bottom_time_min'],
      )!,
      startPressurePsi: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_pressure_psi'],
      ),
      endPressurePsi: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_pressure_psi'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $DivesTable createAlias(String alias) {
    return $DivesTable(attachedDatabase, alias);
  }
}

class Dive extends DataClass implements Insertable<Dive> {
  final String id;
  final DateTime date;
  final String? locationName;
  final int maxDepthFt;
  final int bottomTimeMin;
  final int? startPressurePsi;
  final int? endPressurePsi;
  final String? notes;
  const Dive({
    required this.id,
    required this.date,
    this.locationName,
    required this.maxDepthFt,
    required this.bottomTimeMin,
    this.startPressurePsi,
    this.endPressurePsi,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || locationName != null) {
      map['location_name'] = Variable<String>(locationName);
    }
    map['max_depth_ft'] = Variable<int>(maxDepthFt);
    map['bottom_time_min'] = Variable<int>(bottomTimeMin);
    if (!nullToAbsent || startPressurePsi != null) {
      map['start_pressure_psi'] = Variable<int>(startPressurePsi);
    }
    if (!nullToAbsent || endPressurePsi != null) {
      map['end_pressure_psi'] = Variable<int>(endPressurePsi);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  DivesCompanion toCompanion(bool nullToAbsent) {
    return DivesCompanion(
      id: Value(id),
      date: Value(date),
      locationName: locationName == null && nullToAbsent
          ? const Value.absent()
          : Value(locationName),
      maxDepthFt: Value(maxDepthFt),
      bottomTimeMin: Value(bottomTimeMin),
      startPressurePsi: startPressurePsi == null && nullToAbsent
          ? const Value.absent()
          : Value(startPressurePsi),
      endPressurePsi: endPressurePsi == null && nullToAbsent
          ? const Value.absent()
          : Value(endPressurePsi),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Dive.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dive(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      locationName: serializer.fromJson<String?>(json['locationName']),
      maxDepthFt: serializer.fromJson<int>(json['maxDepthFt']),
      bottomTimeMin: serializer.fromJson<int>(json['bottomTimeMin']),
      startPressurePsi: serializer.fromJson<int?>(json['startPressurePsi']),
      endPressurePsi: serializer.fromJson<int?>(json['endPressurePsi']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'locationName': serializer.toJson<String?>(locationName),
      'maxDepthFt': serializer.toJson<int>(maxDepthFt),
      'bottomTimeMin': serializer.toJson<int>(bottomTimeMin),
      'startPressurePsi': serializer.toJson<int?>(startPressurePsi),
      'endPressurePsi': serializer.toJson<int?>(endPressurePsi),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Dive copyWith({
    String? id,
    DateTime? date,
    Value<String?> locationName = const Value.absent(),
    int? maxDepthFt,
    int? bottomTimeMin,
    Value<int?> startPressurePsi = const Value.absent(),
    Value<int?> endPressurePsi = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => Dive(
    id: id ?? this.id,
    date: date ?? this.date,
    locationName: locationName.present ? locationName.value : this.locationName,
    maxDepthFt: maxDepthFt ?? this.maxDepthFt,
    bottomTimeMin: bottomTimeMin ?? this.bottomTimeMin,
    startPressurePsi: startPressurePsi.present
        ? startPressurePsi.value
        : this.startPressurePsi,
    endPressurePsi: endPressurePsi.present
        ? endPressurePsi.value
        : this.endPressurePsi,
    notes: notes.present ? notes.value : this.notes,
  );
  Dive copyWithCompanion(DivesCompanion data) {
    return Dive(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      maxDepthFt: data.maxDepthFt.present
          ? data.maxDepthFt.value
          : this.maxDepthFt,
      bottomTimeMin: data.bottomTimeMin.present
          ? data.bottomTimeMin.value
          : this.bottomTimeMin,
      startPressurePsi: data.startPressurePsi.present
          ? data.startPressurePsi.value
          : this.startPressurePsi,
      endPressurePsi: data.endPressurePsi.present
          ? data.endPressurePsi.value
          : this.endPressurePsi,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dive(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('locationName: $locationName, ')
          ..write('maxDepthFt: $maxDepthFt, ')
          ..write('bottomTimeMin: $bottomTimeMin, ')
          ..write('startPressurePsi: $startPressurePsi, ')
          ..write('endPressurePsi: $endPressurePsi, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    locationName,
    maxDepthFt,
    bottomTimeMin,
    startPressurePsi,
    endPressurePsi,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dive &&
          other.id == this.id &&
          other.date == this.date &&
          other.locationName == this.locationName &&
          other.maxDepthFt == this.maxDepthFt &&
          other.bottomTimeMin == this.bottomTimeMin &&
          other.startPressurePsi == this.startPressurePsi &&
          other.endPressurePsi == this.endPressurePsi &&
          other.notes == this.notes);
}

class DivesCompanion extends UpdateCompanion<Dive> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String?> locationName;
  final Value<int> maxDepthFt;
  final Value<int> bottomTimeMin;
  final Value<int?> startPressurePsi;
  final Value<int?> endPressurePsi;
  final Value<String?> notes;
  final Value<int> rowid;
  const DivesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.locationName = const Value.absent(),
    this.maxDepthFt = const Value.absent(),
    this.bottomTimeMin = const Value.absent(),
    this.startPressurePsi = const Value.absent(),
    this.endPressurePsi = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DivesCompanion.insert({
    required String id,
    required DateTime date,
    this.locationName = const Value.absent(),
    required int maxDepthFt,
    required int bottomTimeMin,
    this.startPressurePsi = const Value.absent(),
    this.endPressurePsi = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       maxDepthFt = Value(maxDepthFt),
       bottomTimeMin = Value(bottomTimeMin);
  static Insertable<Dive> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? locationName,
    Expression<int>? maxDepthFt,
    Expression<int>? bottomTimeMin,
    Expression<int>? startPressurePsi,
    Expression<int>? endPressurePsi,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (locationName != null) 'location_name': locationName,
      if (maxDepthFt != null) 'max_depth_ft': maxDepthFt,
      if (bottomTimeMin != null) 'bottom_time_min': bottomTimeMin,
      if (startPressurePsi != null) 'start_pressure_psi': startPressurePsi,
      if (endPressurePsi != null) 'end_pressure_psi': endPressurePsi,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DivesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String?>? locationName,
    Value<int>? maxDepthFt,
    Value<int>? bottomTimeMin,
    Value<int?>? startPressurePsi,
    Value<int?>? endPressurePsi,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return DivesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      locationName: locationName ?? this.locationName,
      maxDepthFt: maxDepthFt ?? this.maxDepthFt,
      bottomTimeMin: bottomTimeMin ?? this.bottomTimeMin,
      startPressurePsi: startPressurePsi ?? this.startPressurePsi,
      endPressurePsi: endPressurePsi ?? this.endPressurePsi,
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
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (locationName.present) {
      map['location_name'] = Variable<String>(locationName.value);
    }
    if (maxDepthFt.present) {
      map['max_depth_ft'] = Variable<int>(maxDepthFt.value);
    }
    if (bottomTimeMin.present) {
      map['bottom_time_min'] = Variable<int>(bottomTimeMin.value);
    }
    if (startPressurePsi.present) {
      map['start_pressure_psi'] = Variable<int>(startPressurePsi.value);
    }
    if (endPressurePsi.present) {
      map['end_pressure_psi'] = Variable<int>(endPressurePsi.value);
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
    return (StringBuffer('DivesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('locationName: $locationName, ')
          ..write('maxDepthFt: $maxDepthFt, ')
          ..write('bottomTimeMin: $bottomTimeMin, ')
          ..write('startPressurePsi: $startPressurePsi, ')
          ..write('endPressurePsi: $endPressurePsi, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DivesTable dives = $DivesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dives];
}

typedef $$DivesTableCreateCompanionBuilder =
    DivesCompanion Function({
      required String id,
      required DateTime date,
      Value<String?> locationName,
      required int maxDepthFt,
      required int bottomTimeMin,
      Value<int?> startPressurePsi,
      Value<int?> endPressurePsi,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$DivesTableUpdateCompanionBuilder =
    DivesCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String?> locationName,
      Value<int> maxDepthFt,
      Value<int> bottomTimeMin,
      Value<int?> startPressurePsi,
      Value<int?> endPressurePsi,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$DivesTableFilterComposer extends Composer<_$AppDatabase, $DivesTable> {
  $$DivesTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxDepthFt => $composableBuilder(
    column: $table.maxDepthFt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bottomTimeMin => $composableBuilder(
    column: $table.bottomTimeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startPressurePsi => $composableBuilder(
    column: $table.startPressurePsi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endPressurePsi => $composableBuilder(
    column: $table.endPressurePsi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DivesTableOrderingComposer
    extends Composer<_$AppDatabase, $DivesTable> {
  $$DivesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxDepthFt => $composableBuilder(
    column: $table.maxDepthFt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bottomTimeMin => $composableBuilder(
    column: $table.bottomTimeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startPressurePsi => $composableBuilder(
    column: $table.startPressurePsi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endPressurePsi => $composableBuilder(
    column: $table.endPressurePsi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DivesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DivesTable> {
  $$DivesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxDepthFt => $composableBuilder(
    column: $table.maxDepthFt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bottomTimeMin => $composableBuilder(
    column: $table.bottomTimeMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startPressurePsi => $composableBuilder(
    column: $table.startPressurePsi,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endPressurePsi => $composableBuilder(
    column: $table.endPressurePsi,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$DivesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DivesTable,
          Dive,
          $$DivesTableFilterComposer,
          $$DivesTableOrderingComposer,
          $$DivesTableAnnotationComposer,
          $$DivesTableCreateCompanionBuilder,
          $$DivesTableUpdateCompanionBuilder,
          (Dive, BaseReferences<_$AppDatabase, $DivesTable, Dive>),
          Dive,
          PrefetchHooks Function()
        > {
  $$DivesTableTableManager(_$AppDatabase db, $DivesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DivesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DivesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DivesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> locationName = const Value.absent(),
                Value<int> maxDepthFt = const Value.absent(),
                Value<int> bottomTimeMin = const Value.absent(),
                Value<int?> startPressurePsi = const Value.absent(),
                Value<int?> endPressurePsi = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DivesCompanion(
                id: id,
                date: date,
                locationName: locationName,
                maxDepthFt: maxDepthFt,
                bottomTimeMin: bottomTimeMin,
                startPressurePsi: startPressurePsi,
                endPressurePsi: endPressurePsi,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                Value<String?> locationName = const Value.absent(),
                required int maxDepthFt,
                required int bottomTimeMin,
                Value<int?> startPressurePsi = const Value.absent(),
                Value<int?> endPressurePsi = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DivesCompanion.insert(
                id: id,
                date: date,
                locationName: locationName,
                maxDepthFt: maxDepthFt,
                bottomTimeMin: bottomTimeMin,
                startPressurePsi: startPressurePsi,
                endPressurePsi: endPressurePsi,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DivesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DivesTable,
      Dive,
      $$DivesTableFilterComposer,
      $$DivesTableOrderingComposer,
      $$DivesTableAnnotationComposer,
      $$DivesTableCreateCompanionBuilder,
      $$DivesTableUpdateCompanionBuilder,
      (Dive, BaseReferences<_$AppDatabase, $DivesTable, Dive>),
      Dive,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DivesTableTableManager get dives =>
      $$DivesTableTableManager(_db, _db.dives);
}
