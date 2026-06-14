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

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Dives])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertDive(DivesCompanion entry) async {
    final result = await into(dives).insert(entry);
    print("🔥 INSERT SUCCESS: $result");
    return result;
  }

  Future<List<Dive>> getAllDives() {
    return select(dives).get();
  }

  Future<bool> updateDive(DivesCompanion entry) {
    return update(dives).replace(entry);
  }

  Future<int> deleteDive(String id) {
    return (delete(dives)..where((t) => t.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'dives.sqlite'));
    return NativeDatabase(file);
  });
}

final AppDatabase db = AppDatabase();