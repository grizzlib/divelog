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
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
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
  static const VerificationMeta _diveNumberMeta = const VerificationMeta(
    'diveNumber',
  );
  @override
  late final GeneratedColumn<int> diveNumber = GeneratedColumn<int>(
    'dive_number',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeInMeta = const VerificationMeta('timeIn');
  @override
  late final GeneratedColumn<String> timeIn = GeneratedColumn<String>(
    'time_in',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeOutMeta = const VerificationMeta(
    'timeOut',
  );
  @override
  late final GeneratedColumn<String> timeOut = GeneratedColumn<String>(
    'time_out',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tankTypeMeta = const VerificationMeta(
    'tankType',
  );
  @override
  late final GeneratedColumn<String> tankType = GeneratedColumn<String>(
    'tank_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tankSizeMeta = const VerificationMeta(
    'tankSize',
  );
  @override
  late final GeneratedColumn<double> tankSize = GeneratedColumn<double>(
    'tank_size',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gasMixMeta = const VerificationMeta('gasMix');
  @override
  late final GeneratedColumn<String> gasMix = GeneratedColumn<String>(
    'gas_mix',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightUsedMeta = const VerificationMeta(
    'weightUsed',
  );
  @override
  late final GeneratedColumn<double> weightUsed = GeneratedColumn<double>(
    'weight_used',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activityTypeMeta = const VerificationMeta(
    'activityType',
  );
  @override
  late final GeneratedColumn<String> activityType = GeneratedColumn<String>(
    'activity_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exposureProtectionMeta =
      const VerificationMeta('exposureProtection');
  @override
  late final GeneratedColumn<String> exposureProtection =
      GeneratedColumn<String>(
        'exposure_protection',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _visibilityFtMeta = const VerificationMeta(
    'visibilityFt',
  );
  @override
  late final GeneratedColumn<int> visibilityFt = GeneratedColumn<int>(
    'visibility_ft',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _airTempFMeta = const VerificationMeta(
    'airTempF',
  );
  @override
  late final GeneratedColumn<int> airTempF = GeneratedColumn<int>(
    'air_temp_f',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _surfaceTempFMeta = const VerificationMeta(
    'surfaceTempF',
  );
  @override
  late final GeneratedColumn<int> surfaceTempF = GeneratedColumn<int>(
    'surface_temp_f',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bottomTempFMeta = const VerificationMeta(
    'bottomTempF',
  );
  @override
  late final GeneratedColumn<int> bottomTempF = GeneratedColumn<int>(
    'bottom_temp_f',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
    diveNumber,
    timeIn,
    timeOut,
    tankType,
    tankSize,
    gasMix,
    weightUsed,
    activityType,
    exposureProtection,
    visibilityFt,
    airTempF,
    surfaceTempF,
    bottomTempF,
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
    if (data.containsKey('dive_number')) {
      context.handle(
        _diveNumberMeta,
        diveNumber.isAcceptableOrUnknown(data['dive_number']!, _diveNumberMeta),
      );
    }
    if (data.containsKey('time_in')) {
      context.handle(
        _timeInMeta,
        timeIn.isAcceptableOrUnknown(data['time_in']!, _timeInMeta),
      );
    }
    if (data.containsKey('time_out')) {
      context.handle(
        _timeOutMeta,
        timeOut.isAcceptableOrUnknown(data['time_out']!, _timeOutMeta),
      );
    }
    if (data.containsKey('tank_type')) {
      context.handle(
        _tankTypeMeta,
        tankType.isAcceptableOrUnknown(data['tank_type']!, _tankTypeMeta),
      );
    }
    if (data.containsKey('tank_size')) {
      context.handle(
        _tankSizeMeta,
        tankSize.isAcceptableOrUnknown(data['tank_size']!, _tankSizeMeta),
      );
    }
    if (data.containsKey('gas_mix')) {
      context.handle(
        _gasMixMeta,
        gasMix.isAcceptableOrUnknown(data['gas_mix']!, _gasMixMeta),
      );
    }
    if (data.containsKey('weight_used')) {
      context.handle(
        _weightUsedMeta,
        weightUsed.isAcceptableOrUnknown(data['weight_used']!, _weightUsedMeta),
      );
    }
    if (data.containsKey('activity_type')) {
      context.handle(
        _activityTypeMeta,
        activityType.isAcceptableOrUnknown(
          data['activity_type']!,
          _activityTypeMeta,
        ),
      );
    }
    if (data.containsKey('exposure_protection')) {
      context.handle(
        _exposureProtectionMeta,
        exposureProtection.isAcceptableOrUnknown(
          data['exposure_protection']!,
          _exposureProtectionMeta,
        ),
      );
    }
    if (data.containsKey('visibility_ft')) {
      context.handle(
        _visibilityFtMeta,
        visibilityFt.isAcceptableOrUnknown(
          data['visibility_ft']!,
          _visibilityFtMeta,
        ),
      );
    }
    if (data.containsKey('air_temp_f')) {
      context.handle(
        _airTempFMeta,
        airTempF.isAcceptableOrUnknown(data['air_temp_f']!, _airTempFMeta),
      );
    }
    if (data.containsKey('surface_temp_f')) {
      context.handle(
        _surfaceTempFMeta,
        surfaceTempF.isAcceptableOrUnknown(
          data['surface_temp_f']!,
          _surfaceTempFMeta,
        ),
      );
    }
    if (data.containsKey('bottom_temp_f')) {
      context.handle(
        _bottomTempFMeta,
        bottomTempF.isAcceptableOrUnknown(
          data['bottom_temp_f']!,
          _bottomTempFMeta,
        ),
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
      diveNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dive_number'],
      ),
      timeIn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_in'],
      ),
      timeOut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_out'],
      ),
      tankType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tank_type'],
      ),
      tankSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tank_size'],
      ),
      gasMix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gas_mix'],
      ),
      weightUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_used'],
      ),
      activityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_type'],
      ),
      exposureProtection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exposure_protection'],
      ),
      visibilityFt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}visibility_ft'],
      ),
      airTempF: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}air_temp_f'],
      ),
      surfaceTempF: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surface_temp_f'],
      ),
      bottomTempF: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bottom_temp_f'],
      ),
    );
  }

  @override
  $DivesTable createAlias(String alias) {
    return $DivesTable(attachedDatabase, alias);
  }
}

class Dive extends DataClass implements Insertable<Dive> {
  /// Unique ID for each dive.
  ///
  /// Generated automatically using UUID when a new dive is inserted.
  final String id;

  /// Calendar date of the dive.
  final DateTime date;

  /// Dive site or general location name.
  final String? locationName;

  /// Maximum depth reached, stored in feet.
  final int maxDepthFt;

  /// Bottom time, stored in minutes.
  final int bottomTimeMin;

  /// Starting tank pressure, stored in PSI.
  final int? startPressurePsi;

  /// Ending tank pressure, stored in PSI.
  final int? endPressurePsi;

  /// Free-form notes about the dive.
  final String? notes;

  /// Optional dive number from a physical logbook or sequence.
  final int? diveNumber;

  /// Time the dive started.
  ///
  /// Stored as text for now to keep entry simple.
  /// Future change point:
  /// We may later move this to a real time/date type if needed.
  final String? timeIn;

  /// Time the dive ended.
  ///
  /// Stored as text for now to keep entry simple.
  final String? timeOut;

  /// Tank material/type, such as Aluminum or Steel.
  final String? tankType;

  /// Tank size, stored as a real number for future SAC/RMV calculations.
  final double? tankSize;

  /// Breathing gas, such as Air, Nitrox, or Other.
  final String? gasMix;

  /// Weight used, stored as a real number in pounds.
  final double? weightUsed;

  /// General activity type, such as Recreational, Training, Wreck, etc.
  final String? activityType;

  /// Exposure protection used for the dive.
  ///
  /// Examples:
  /// None, Rash Guard, 3mm Wetsuit, 5mm Wetsuit, Drysuit, etc.
  final String? exposureProtection;

  /// Visibility, stored in feet.
  final int? visibilityFt;

  /// Air temperature, stored in Fahrenheit.
  final int? airTempF;

  /// Surface water temperature, stored in Fahrenheit.
  final int? surfaceTempF;

  /// Bottom water temperature, stored in Fahrenheit.
  final int? bottomTempF;
  const Dive({
    required this.id,
    required this.date,
    this.locationName,
    required this.maxDepthFt,
    required this.bottomTimeMin,
    this.startPressurePsi,
    this.endPressurePsi,
    this.notes,
    this.diveNumber,
    this.timeIn,
    this.timeOut,
    this.tankType,
    this.tankSize,
    this.gasMix,
    this.weightUsed,
    this.activityType,
    this.exposureProtection,
    this.visibilityFt,
    this.airTempF,
    this.surfaceTempF,
    this.bottomTempF,
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
    if (!nullToAbsent || diveNumber != null) {
      map['dive_number'] = Variable<int>(diveNumber);
    }
    if (!nullToAbsent || timeIn != null) {
      map['time_in'] = Variable<String>(timeIn);
    }
    if (!nullToAbsent || timeOut != null) {
      map['time_out'] = Variable<String>(timeOut);
    }
    if (!nullToAbsent || tankType != null) {
      map['tank_type'] = Variable<String>(tankType);
    }
    if (!nullToAbsent || tankSize != null) {
      map['tank_size'] = Variable<double>(tankSize);
    }
    if (!nullToAbsent || gasMix != null) {
      map['gas_mix'] = Variable<String>(gasMix);
    }
    if (!nullToAbsent || weightUsed != null) {
      map['weight_used'] = Variable<double>(weightUsed);
    }
    if (!nullToAbsent || activityType != null) {
      map['activity_type'] = Variable<String>(activityType);
    }
    if (!nullToAbsent || exposureProtection != null) {
      map['exposure_protection'] = Variable<String>(exposureProtection);
    }
    if (!nullToAbsent || visibilityFt != null) {
      map['visibility_ft'] = Variable<int>(visibilityFt);
    }
    if (!nullToAbsent || airTempF != null) {
      map['air_temp_f'] = Variable<int>(airTempF);
    }
    if (!nullToAbsent || surfaceTempF != null) {
      map['surface_temp_f'] = Variable<int>(surfaceTempF);
    }
    if (!nullToAbsent || bottomTempF != null) {
      map['bottom_temp_f'] = Variable<int>(bottomTempF);
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
      diveNumber: diveNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(diveNumber),
      timeIn: timeIn == null && nullToAbsent
          ? const Value.absent()
          : Value(timeIn),
      timeOut: timeOut == null && nullToAbsent
          ? const Value.absent()
          : Value(timeOut),
      tankType: tankType == null && nullToAbsent
          ? const Value.absent()
          : Value(tankType),
      tankSize: tankSize == null && nullToAbsent
          ? const Value.absent()
          : Value(tankSize),
      gasMix: gasMix == null && nullToAbsent
          ? const Value.absent()
          : Value(gasMix),
      weightUsed: weightUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(weightUsed),
      activityType: activityType == null && nullToAbsent
          ? const Value.absent()
          : Value(activityType),
      exposureProtection: exposureProtection == null && nullToAbsent
          ? const Value.absent()
          : Value(exposureProtection),
      visibilityFt: visibilityFt == null && nullToAbsent
          ? const Value.absent()
          : Value(visibilityFt),
      airTempF: airTempF == null && nullToAbsent
          ? const Value.absent()
          : Value(airTempF),
      surfaceTempF: surfaceTempF == null && nullToAbsent
          ? const Value.absent()
          : Value(surfaceTempF),
      bottomTempF: bottomTempF == null && nullToAbsent
          ? const Value.absent()
          : Value(bottomTempF),
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
      diveNumber: serializer.fromJson<int?>(json['diveNumber']),
      timeIn: serializer.fromJson<String?>(json['timeIn']),
      timeOut: serializer.fromJson<String?>(json['timeOut']),
      tankType: serializer.fromJson<String?>(json['tankType']),
      tankSize: serializer.fromJson<double?>(json['tankSize']),
      gasMix: serializer.fromJson<String?>(json['gasMix']),
      weightUsed: serializer.fromJson<double?>(json['weightUsed']),
      activityType: serializer.fromJson<String?>(json['activityType']),
      exposureProtection: serializer.fromJson<String?>(
        json['exposureProtection'],
      ),
      visibilityFt: serializer.fromJson<int?>(json['visibilityFt']),
      airTempF: serializer.fromJson<int?>(json['airTempF']),
      surfaceTempF: serializer.fromJson<int?>(json['surfaceTempF']),
      bottomTempF: serializer.fromJson<int?>(json['bottomTempF']),
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
      'diveNumber': serializer.toJson<int?>(diveNumber),
      'timeIn': serializer.toJson<String?>(timeIn),
      'timeOut': serializer.toJson<String?>(timeOut),
      'tankType': serializer.toJson<String?>(tankType),
      'tankSize': serializer.toJson<double?>(tankSize),
      'gasMix': serializer.toJson<String?>(gasMix),
      'weightUsed': serializer.toJson<double?>(weightUsed),
      'activityType': serializer.toJson<String?>(activityType),
      'exposureProtection': serializer.toJson<String?>(exposureProtection),
      'visibilityFt': serializer.toJson<int?>(visibilityFt),
      'airTempF': serializer.toJson<int?>(airTempF),
      'surfaceTempF': serializer.toJson<int?>(surfaceTempF),
      'bottomTempF': serializer.toJson<int?>(bottomTempF),
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
    Value<int?> diveNumber = const Value.absent(),
    Value<String?> timeIn = const Value.absent(),
    Value<String?> timeOut = const Value.absent(),
    Value<String?> tankType = const Value.absent(),
    Value<double?> tankSize = const Value.absent(),
    Value<String?> gasMix = const Value.absent(),
    Value<double?> weightUsed = const Value.absent(),
    Value<String?> activityType = const Value.absent(),
    Value<String?> exposureProtection = const Value.absent(),
    Value<int?> visibilityFt = const Value.absent(),
    Value<int?> airTempF = const Value.absent(),
    Value<int?> surfaceTempF = const Value.absent(),
    Value<int?> bottomTempF = const Value.absent(),
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
    diveNumber: diveNumber.present ? diveNumber.value : this.diveNumber,
    timeIn: timeIn.present ? timeIn.value : this.timeIn,
    timeOut: timeOut.present ? timeOut.value : this.timeOut,
    tankType: tankType.present ? tankType.value : this.tankType,
    tankSize: tankSize.present ? tankSize.value : this.tankSize,
    gasMix: gasMix.present ? gasMix.value : this.gasMix,
    weightUsed: weightUsed.present ? weightUsed.value : this.weightUsed,
    activityType: activityType.present ? activityType.value : this.activityType,
    exposureProtection: exposureProtection.present
        ? exposureProtection.value
        : this.exposureProtection,
    visibilityFt: visibilityFt.present ? visibilityFt.value : this.visibilityFt,
    airTempF: airTempF.present ? airTempF.value : this.airTempF,
    surfaceTempF: surfaceTempF.present ? surfaceTempF.value : this.surfaceTempF,
    bottomTempF: bottomTempF.present ? bottomTempF.value : this.bottomTempF,
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
      diveNumber: data.diveNumber.present
          ? data.diveNumber.value
          : this.diveNumber,
      timeIn: data.timeIn.present ? data.timeIn.value : this.timeIn,
      timeOut: data.timeOut.present ? data.timeOut.value : this.timeOut,
      tankType: data.tankType.present ? data.tankType.value : this.tankType,
      tankSize: data.tankSize.present ? data.tankSize.value : this.tankSize,
      gasMix: data.gasMix.present ? data.gasMix.value : this.gasMix,
      weightUsed: data.weightUsed.present
          ? data.weightUsed.value
          : this.weightUsed,
      activityType: data.activityType.present
          ? data.activityType.value
          : this.activityType,
      exposureProtection: data.exposureProtection.present
          ? data.exposureProtection.value
          : this.exposureProtection,
      visibilityFt: data.visibilityFt.present
          ? data.visibilityFt.value
          : this.visibilityFt,
      airTempF: data.airTempF.present ? data.airTempF.value : this.airTempF,
      surfaceTempF: data.surfaceTempF.present
          ? data.surfaceTempF.value
          : this.surfaceTempF,
      bottomTempF: data.bottomTempF.present
          ? data.bottomTempF.value
          : this.bottomTempF,
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
          ..write('notes: $notes, ')
          ..write('diveNumber: $diveNumber, ')
          ..write('timeIn: $timeIn, ')
          ..write('timeOut: $timeOut, ')
          ..write('tankType: $tankType, ')
          ..write('tankSize: $tankSize, ')
          ..write('gasMix: $gasMix, ')
          ..write('weightUsed: $weightUsed, ')
          ..write('activityType: $activityType, ')
          ..write('exposureProtection: $exposureProtection, ')
          ..write('visibilityFt: $visibilityFt, ')
          ..write('airTempF: $airTempF, ')
          ..write('surfaceTempF: $surfaceTempF, ')
          ..write('bottomTempF: $bottomTempF')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    date,
    locationName,
    maxDepthFt,
    bottomTimeMin,
    startPressurePsi,
    endPressurePsi,
    notes,
    diveNumber,
    timeIn,
    timeOut,
    tankType,
    tankSize,
    gasMix,
    weightUsed,
    activityType,
    exposureProtection,
    visibilityFt,
    airTempF,
    surfaceTempF,
    bottomTempF,
  ]);
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
          other.notes == this.notes &&
          other.diveNumber == this.diveNumber &&
          other.timeIn == this.timeIn &&
          other.timeOut == this.timeOut &&
          other.tankType == this.tankType &&
          other.tankSize == this.tankSize &&
          other.gasMix == this.gasMix &&
          other.weightUsed == this.weightUsed &&
          other.activityType == this.activityType &&
          other.exposureProtection == this.exposureProtection &&
          other.visibilityFt == this.visibilityFt &&
          other.airTempF == this.airTempF &&
          other.surfaceTempF == this.surfaceTempF &&
          other.bottomTempF == this.bottomTempF);
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
  final Value<int?> diveNumber;
  final Value<String?> timeIn;
  final Value<String?> timeOut;
  final Value<String?> tankType;
  final Value<double?> tankSize;
  final Value<String?> gasMix;
  final Value<double?> weightUsed;
  final Value<String?> activityType;
  final Value<String?> exposureProtection;
  final Value<int?> visibilityFt;
  final Value<int?> airTempF;
  final Value<int?> surfaceTempF;
  final Value<int?> bottomTempF;
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
    this.diveNumber = const Value.absent(),
    this.timeIn = const Value.absent(),
    this.timeOut = const Value.absent(),
    this.tankType = const Value.absent(),
    this.tankSize = const Value.absent(),
    this.gasMix = const Value.absent(),
    this.weightUsed = const Value.absent(),
    this.activityType = const Value.absent(),
    this.exposureProtection = const Value.absent(),
    this.visibilityFt = const Value.absent(),
    this.airTempF = const Value.absent(),
    this.surfaceTempF = const Value.absent(),
    this.bottomTempF = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DivesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.locationName = const Value.absent(),
    required int maxDepthFt,
    required int bottomTimeMin,
    this.startPressurePsi = const Value.absent(),
    this.endPressurePsi = const Value.absent(),
    this.notes = const Value.absent(),
    this.diveNumber = const Value.absent(),
    this.timeIn = const Value.absent(),
    this.timeOut = const Value.absent(),
    this.tankType = const Value.absent(),
    this.tankSize = const Value.absent(),
    this.gasMix = const Value.absent(),
    this.weightUsed = const Value.absent(),
    this.activityType = const Value.absent(),
    this.exposureProtection = const Value.absent(),
    this.visibilityFt = const Value.absent(),
    this.airTempF = const Value.absent(),
    this.surfaceTempF = const Value.absent(),
    this.bottomTempF = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date),
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
    Expression<int>? diveNumber,
    Expression<String>? timeIn,
    Expression<String>? timeOut,
    Expression<String>? tankType,
    Expression<double>? tankSize,
    Expression<String>? gasMix,
    Expression<double>? weightUsed,
    Expression<String>? activityType,
    Expression<String>? exposureProtection,
    Expression<int>? visibilityFt,
    Expression<int>? airTempF,
    Expression<int>? surfaceTempF,
    Expression<int>? bottomTempF,
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
      if (diveNumber != null) 'dive_number': diveNumber,
      if (timeIn != null) 'time_in': timeIn,
      if (timeOut != null) 'time_out': timeOut,
      if (tankType != null) 'tank_type': tankType,
      if (tankSize != null) 'tank_size': tankSize,
      if (gasMix != null) 'gas_mix': gasMix,
      if (weightUsed != null) 'weight_used': weightUsed,
      if (activityType != null) 'activity_type': activityType,
      if (exposureProtection != null) 'exposure_protection': exposureProtection,
      if (visibilityFt != null) 'visibility_ft': visibilityFt,
      if (airTempF != null) 'air_temp_f': airTempF,
      if (surfaceTempF != null) 'surface_temp_f': surfaceTempF,
      if (bottomTempF != null) 'bottom_temp_f': bottomTempF,
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
    Value<int?>? diveNumber,
    Value<String?>? timeIn,
    Value<String?>? timeOut,
    Value<String?>? tankType,
    Value<double?>? tankSize,
    Value<String?>? gasMix,
    Value<double?>? weightUsed,
    Value<String?>? activityType,
    Value<String?>? exposureProtection,
    Value<int?>? visibilityFt,
    Value<int?>? airTempF,
    Value<int?>? surfaceTempF,
    Value<int?>? bottomTempF,
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
      diveNumber: diveNumber ?? this.diveNumber,
      timeIn: timeIn ?? this.timeIn,
      timeOut: timeOut ?? this.timeOut,
      tankType: tankType ?? this.tankType,
      tankSize: tankSize ?? this.tankSize,
      gasMix: gasMix ?? this.gasMix,
      weightUsed: weightUsed ?? this.weightUsed,
      activityType: activityType ?? this.activityType,
      exposureProtection: exposureProtection ?? this.exposureProtection,
      visibilityFt: visibilityFt ?? this.visibilityFt,
      airTempF: airTempF ?? this.airTempF,
      surfaceTempF: surfaceTempF ?? this.surfaceTempF,
      bottomTempF: bottomTempF ?? this.bottomTempF,
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
    if (diveNumber.present) {
      map['dive_number'] = Variable<int>(diveNumber.value);
    }
    if (timeIn.present) {
      map['time_in'] = Variable<String>(timeIn.value);
    }
    if (timeOut.present) {
      map['time_out'] = Variable<String>(timeOut.value);
    }
    if (tankType.present) {
      map['tank_type'] = Variable<String>(tankType.value);
    }
    if (tankSize.present) {
      map['tank_size'] = Variable<double>(tankSize.value);
    }
    if (gasMix.present) {
      map['gas_mix'] = Variable<String>(gasMix.value);
    }
    if (weightUsed.present) {
      map['weight_used'] = Variable<double>(weightUsed.value);
    }
    if (activityType.present) {
      map['activity_type'] = Variable<String>(activityType.value);
    }
    if (exposureProtection.present) {
      map['exposure_protection'] = Variable<String>(exposureProtection.value);
    }
    if (visibilityFt.present) {
      map['visibility_ft'] = Variable<int>(visibilityFt.value);
    }
    if (airTempF.present) {
      map['air_temp_f'] = Variable<int>(airTempF.value);
    }
    if (surfaceTempF.present) {
      map['surface_temp_f'] = Variable<int>(surfaceTempF.value);
    }
    if (bottomTempF.present) {
      map['bottom_temp_f'] = Variable<int>(bottomTempF.value);
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
          ..write('diveNumber: $diveNumber, ')
          ..write('timeIn: $timeIn, ')
          ..write('timeOut: $timeOut, ')
          ..write('tankType: $tankType, ')
          ..write('tankSize: $tankSize, ')
          ..write('gasMix: $gasMix, ')
          ..write('weightUsed: $weightUsed, ')
          ..write('activityType: $activityType, ')
          ..write('exposureProtection: $exposureProtection, ')
          ..write('visibilityFt: $visibilityFt, ')
          ..write('airTempF: $airTempF, ')
          ..write('surfaceTempF: $surfaceTempF, ')
          ..write('bottomTempF: $bottomTempF, ')
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
      Value<String> id,
      required DateTime date,
      Value<String?> locationName,
      required int maxDepthFt,
      required int bottomTimeMin,
      Value<int?> startPressurePsi,
      Value<int?> endPressurePsi,
      Value<String?> notes,
      Value<int?> diveNumber,
      Value<String?> timeIn,
      Value<String?> timeOut,
      Value<String?> tankType,
      Value<double?> tankSize,
      Value<String?> gasMix,
      Value<double?> weightUsed,
      Value<String?> activityType,
      Value<String?> exposureProtection,
      Value<int?> visibilityFt,
      Value<int?> airTempF,
      Value<int?> surfaceTempF,
      Value<int?> bottomTempF,
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
      Value<int?> diveNumber,
      Value<String?> timeIn,
      Value<String?> timeOut,
      Value<String?> tankType,
      Value<double?> tankSize,
      Value<String?> gasMix,
      Value<double?> weightUsed,
      Value<String?> activityType,
      Value<String?> exposureProtection,
      Value<int?> visibilityFt,
      Value<int?> airTempF,
      Value<int?> surfaceTempF,
      Value<int?> bottomTempF,
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

  ColumnFilters<int> get diveNumber => $composableBuilder(
    column: $table.diveNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeIn => $composableBuilder(
    column: $table.timeIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOut => $composableBuilder(
    column: $table.timeOut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tankType => $composableBuilder(
    column: $table.tankType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tankSize => $composableBuilder(
    column: $table.tankSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gasMix => $composableBuilder(
    column: $table.gasMix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightUsed => $composableBuilder(
    column: $table.weightUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exposureProtection => $composableBuilder(
    column: $table.exposureProtection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get visibilityFt => $composableBuilder(
    column: $table.visibilityFt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get airTempF => $composableBuilder(
    column: $table.airTempF,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surfaceTempF => $composableBuilder(
    column: $table.surfaceTempF,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bottomTempF => $composableBuilder(
    column: $table.bottomTempF,
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

  ColumnOrderings<int> get diveNumber => $composableBuilder(
    column: $table.diveNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeIn => $composableBuilder(
    column: $table.timeIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOut => $composableBuilder(
    column: $table.timeOut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tankType => $composableBuilder(
    column: $table.tankType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tankSize => $composableBuilder(
    column: $table.tankSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gasMix => $composableBuilder(
    column: $table.gasMix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightUsed => $composableBuilder(
    column: $table.weightUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exposureProtection => $composableBuilder(
    column: $table.exposureProtection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get visibilityFt => $composableBuilder(
    column: $table.visibilityFt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get airTempF => $composableBuilder(
    column: $table.airTempF,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surfaceTempF => $composableBuilder(
    column: $table.surfaceTempF,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bottomTempF => $composableBuilder(
    column: $table.bottomTempF,
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

  GeneratedColumn<int> get diveNumber => $composableBuilder(
    column: $table.diveNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timeIn =>
      $composableBuilder(column: $table.timeIn, builder: (column) => column);

  GeneratedColumn<String> get timeOut =>
      $composableBuilder(column: $table.timeOut, builder: (column) => column);

  GeneratedColumn<String> get tankType =>
      $composableBuilder(column: $table.tankType, builder: (column) => column);

  GeneratedColumn<double> get tankSize =>
      $composableBuilder(column: $table.tankSize, builder: (column) => column);

  GeneratedColumn<String> get gasMix =>
      $composableBuilder(column: $table.gasMix, builder: (column) => column);

  GeneratedColumn<double> get weightUsed => $composableBuilder(
    column: $table.weightUsed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exposureProtection => $composableBuilder(
    column: $table.exposureProtection,
    builder: (column) => column,
  );

  GeneratedColumn<int> get visibilityFt => $composableBuilder(
    column: $table.visibilityFt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get airTempF =>
      $composableBuilder(column: $table.airTempF, builder: (column) => column);

  GeneratedColumn<int> get surfaceTempF => $composableBuilder(
    column: $table.surfaceTempF,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bottomTempF => $composableBuilder(
    column: $table.bottomTempF,
    builder: (column) => column,
  );
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
                Value<int?> diveNumber = const Value.absent(),
                Value<String?> timeIn = const Value.absent(),
                Value<String?> timeOut = const Value.absent(),
                Value<String?> tankType = const Value.absent(),
                Value<double?> tankSize = const Value.absent(),
                Value<String?> gasMix = const Value.absent(),
                Value<double?> weightUsed = const Value.absent(),
                Value<String?> activityType = const Value.absent(),
                Value<String?> exposureProtection = const Value.absent(),
                Value<int?> visibilityFt = const Value.absent(),
                Value<int?> airTempF = const Value.absent(),
                Value<int?> surfaceTempF = const Value.absent(),
                Value<int?> bottomTempF = const Value.absent(),
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
                diveNumber: diveNumber,
                timeIn: timeIn,
                timeOut: timeOut,
                tankType: tankType,
                tankSize: tankSize,
                gasMix: gasMix,
                weightUsed: weightUsed,
                activityType: activityType,
                exposureProtection: exposureProtection,
                visibilityFt: visibilityFt,
                airTempF: airTempF,
                surfaceTempF: surfaceTempF,
                bottomTempF: bottomTempF,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required DateTime date,
                Value<String?> locationName = const Value.absent(),
                required int maxDepthFt,
                required int bottomTimeMin,
                Value<int?> startPressurePsi = const Value.absent(),
                Value<int?> endPressurePsi = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> diveNumber = const Value.absent(),
                Value<String?> timeIn = const Value.absent(),
                Value<String?> timeOut = const Value.absent(),
                Value<String?> tankType = const Value.absent(),
                Value<double?> tankSize = const Value.absent(),
                Value<String?> gasMix = const Value.absent(),
                Value<double?> weightUsed = const Value.absent(),
                Value<String?> activityType = const Value.absent(),
                Value<String?> exposureProtection = const Value.absent(),
                Value<int?> visibilityFt = const Value.absent(),
                Value<int?> airTempF = const Value.absent(),
                Value<int?> surfaceTempF = const Value.absent(),
                Value<int?> bottomTempF = const Value.absent(),
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
                diveNumber: diveNumber,
                timeIn: timeIn,
                timeOut: timeOut,
                tankType: tankType,
                tankSize: tankSize,
                gasMix: gasMix,
                weightUsed: weightUsed,
                activityType: activityType,
                exposureProtection: exposureProtection,
                visibilityFt: visibilityFt,
                airTempF: airTempF,
                surfaceTempF: surfaceTempF,
                bottomTempF: bottomTempF,
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
