import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

/// Main database table for logged dives.
///
/// Each row represents one dive entry.
///
/// Future change point:
/// When we add new saved fields to the dive log, they usually need to be added:
/// 1. Here in the Dives table
/// 2. In schemaVersion / migration below
/// 3. In Add Dive screen
/// 4. In Edit Dive screen
/// 5. In Dive Details screen
class Dives extends Table {
  // ---------------------------------------------------------------------------
  // Core identity/date fields
  // ---------------------------------------------------------------------------

  /// Unique ID for each dive.
  ///
  /// Generated automatically using UUID when a new dive is inserted.
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  /// Calendar date of the dive.
  DateTimeColumn get date => dateTime()();

  /// Dive site or general location name.
  TextColumn get locationName => text().nullable()();

  // ---------------------------------------------------------------------------
  // Core dive metrics
  // ---------------------------------------------------------------------------

  /// Maximum depth reached, stored in feet.
  IntColumn get maxDepthFt => integer()();

  /// Bottom time, stored in minutes.
  IntColumn get bottomTimeMin => integer()();

  /// Starting tank pressure, stored in PSI.
  IntColumn get startPressurePsi => integer().nullable()();

  /// Ending tank pressure, stored in PSI.
  IntColumn get endPressurePsi => integer().nullable()();

  /// Free-form notes about the dive.
  TextColumn get notes => text().nullable()();

  // ---------------------------------------------------------------------------
  // Phase 1 - V2 Schema
  // ---------------------------------------------------------------------------

  /// Optional dive number from a physical logbook or sequence.
  IntColumn get diveNumber => integer().nullable()();

  /// Time the dive started.
  ///
  /// Stored as text for now to keep entry simple.
  /// Future change point:
  /// We may later move this to a real time/date type if needed.
  TextColumn get timeIn => text().nullable()();

  /// Time the dive ended.
  ///
  /// Stored as text for now to keep entry simple.
  TextColumn get timeOut => text().nullable()();

  /// Tank material/type, such as Aluminum or Steel.
  TextColumn get tankType => text().nullable()();

  /// Tank size, stored as a real number for future SAC/RMV calculations.
  RealColumn get tankSize => real().nullable()();

  /// Breathing gas, such as Air, Nitrox, or Other.
  TextColumn get gasMix => text().nullable()();

  /// Weight used, stored as a real number in pounds.
  RealColumn get weightUsed => real().nullable()();

  /// General activity type, such as Recreational, Training, Wreck, etc.
  TextColumn get activityType => text().nullable()();

  // ---------------------------------------------------------------------------
  // Phase 2 - V3 Schema
  // ---------------------------------------------------------------------------

  /// Exposure protection used for the dive.
  ///
  /// Examples:
  /// None, Rash Guard, 3mm Wetsuit, 5mm Wetsuit, Drysuit, etc.
  TextColumn get exposureProtection => text().nullable()();

  /// Visibility, stored in feet.
  IntColumn get visibilityFt => integer().nullable()();

  /// Air temperature, stored in Fahrenheit.
  IntColumn get airTempF => integer().nullable()();

  /// Surface water temperature, stored in Fahrenheit.
  IntColumn get surfaceTempF => integer().nullable()();

  /// Bottom water temperature, stored in Fahrenheit.
  IntColumn get bottomTempF => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Dives])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Current database schema version.
  ///
  /// Version history:
  /// - V1: Original dive fields
  /// - V2: Dive number, time in/out, tank, gas, weight, activity
  /// - V3: Exposure protection, visibility, air/surface/bottom temps
  @override
  int get schemaVersion => 3;

  /// Handles creating and upgrading the local SQLite database.
  ///
  /// Important:
  /// Whenever schemaVersion is increased, add a matching upgrade block here.
  ///
  /// This allows existing installed apps to keep their old dive data while
  /// adding the new columns.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        /// Runs when the database is created for the first time.
        onCreate: (m) async => m.createAll(),

        /// Runs when an existing database needs to be upgraded.
        onUpgrade: (m, from, to) async {
          // -----------------------------------------------------------------
          // Upgrade from V1 to V2
          // -----------------------------------------------------------------
          if (from < 2) {
            await m.addColumn(dives, dives.diveNumber);
            await m.addColumn(dives, dives.timeIn);
            await m.addColumn(dives, dives.timeOut);
            await m.addColumn(dives, dives.tankType);
            await m.addColumn(dives, dives.tankSize);
            await m.addColumn(dives, dives.gasMix);
            await m.addColumn(dives, dives.weightUsed);
            await m.addColumn(dives, dives.activityType);
          }

          // -----------------------------------------------------------------
          // Upgrade from V2 to V3
          // -----------------------------------------------------------------
          if (from < 3) {
            await m.addColumn(dives, dives.exposureProtection);
            await m.addColumn(dives, dives.visibilityFt);
            await m.addColumn(dives, dives.airTempF);
            await m.addColumn(dives, dives.surfaceTempF);
            await m.addColumn(dives, dives.bottomTempF);
          }
        },
      );

  // ---------------------------------------------------------------------------
  // Basic CRUD helpers
  // ---------------------------------------------------------------------------

  /// Inserts a new dive into the database.
  Future<int> insertDive(DivesCompanion entry) => into(dives).insert(entry);

  /// Returns all dives currently stored.
  ///
  /// Future change point:
  /// We may later add sorted versions, filtered versions, or date-range queries.
  Future<List<Dive>> getAllDives() => select(dives).get();

  /// Updates an existing dive.
  ///
  /// The companion must include the existing dive ID.
  Future<bool> updateDive(DivesCompanion entry) => update(dives).replace(entry);

  /// Deletes a dive by ID.
  Future<int> deleteDive(String id) =>
      (delete(dives)..where((t) => t.id.equals(id))).go();
}

/// Opens the local SQLite database file.
///
/// The database is stored in the app's documents directory as:
/// dives.sqlite
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'dives.sqlite'));
    return NativeDatabase(file);
  });
}

/// Shared database instance used by the app screens.
final AppDatabase db = AppDatabase();