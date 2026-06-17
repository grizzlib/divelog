import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

class Dives extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  DateTimeColumn get date => dateTime()();

  TextColumn get locationName => text().nullable()();

  IntColumn get maxDepthFt => integer()();
  IntColumn get bottomTimeMin => integer()();

  IntColumn get startPressurePsi => integer().nullable()();
  IntColumn get endPressurePsi => integer().nullable()();

  TextColumn get notes => text().nullable()();

  // =========================
  // Phase 1 - V2 Schema
  // =========================

  IntColumn get diveNumber => integer().nullable()();

  TextColumn get timeIn => text().nullable()();
  TextColumn get timeOut => text().nullable()();

  TextColumn get tankType => text().nullable()();

  // numeric real values (important for future SAC/RMV calculations)
  RealColumn get tankSize => real().nullable()();

  TextColumn get gasMix => text().nullable()();

  RealColumn get weightUsed => real().nullable()();

  TextColumn get activityType => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Dives])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
        onUpgrade: (m, from, to) async {
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
        },
      );

  Future<int> insertDive(DivesCompanion entry) => into(dives).insert(entry);

  Future<List<Dive>> getAllDives() => select(dives).get();

  Future<bool> updateDive(DivesCompanion entry) =>
      update(dives).replace(entry);

  Future<int> deleteDive(String id) =>
      (delete(dives)..where((t) => t.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'dives.sqlite'));
    return NativeDatabase(file);
  });
}

final AppDatabase db = AppDatabase();
