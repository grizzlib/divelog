import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Dives extends Table {
  TextColumn get id => text()();
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

 // Future<int> insertDive(DivesCompanion entry) {
 //   return into(dives).insert(entry);
 // }
  Future<int> insertDive(DivesCompanion entry) async {
  final result = await into(dives).insert(entry);
  print("🔥 INSERT SUCCESS: $result");
  return result;
}

   Future<List<Dive>> getAllDives() {
     return select(dives).get();
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