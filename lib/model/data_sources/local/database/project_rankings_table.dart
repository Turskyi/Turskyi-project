import 'package:drift/drift.dart';

class ProjectRankingsTable extends Table {
  TextColumn get id => text()();

  IntColumn get total => integer()();

  IntColumn get ios => integer()();

  IntColumn get android => integer()();

  IntColumn get web => integer()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => <Column<Object>>{id};
}
