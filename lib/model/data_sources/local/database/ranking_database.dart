import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:turskyi/model/data_sources/local/database/project_rankings_table.dart';
import 'package:turskyi/model/data_sources/local/database/ranking_metadata_table.dart';
import 'package:turskyi/model/models/project_ranking.dart';

part 'ranking_database.g.dart';

@DriftDatabase(tables: <Type>[ProjectRankingsTable, RankingMetadataTable])
class RankingDatabase extends _$RankingDatabase {
  RankingDatabase([final QueryExecutor? executor])
    : super(executor ?? _openConnection());

  RankingDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  Future<List<ProjectRanking>> getAllRankings() async {
    final List<ProjectRankingsTableData> rows = await select(
      projectRankingsTable,
    ).get();
    return rows
        .map(
          (final ProjectRankingsTableData row) => ProjectRanking(
            id: row.id,
            total: row.total,
            ios: row.ios,
            android: row.android,
            web: row.web,
            updatedAt: row.updatedAt,
          ),
        )
        .toList();
  }

  Future<void> saveRankings(final List<ProjectRanking> rankings) async {
    await batch((final Batch batch) {
      for (final ProjectRanking ranking in rankings) {
        batch.insert(
          projectRankingsTable,
          ProjectRankingsTableCompanion.insert(
            id: ranking.id,
            total: ranking.total,
            ios: ranking.ios,
            android: ranking.android,
            web: ranking.web,
            updatedAt: ranking.updatedAt,
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<DateTime?> getLastFetchedAt() async {
    final RankingMetadataTableData? row =
        await (select(rankingMetadataTable)..where(
              (final $RankingMetadataTableTable t) =>
                  t.key.equals('last_fetched_at'),
            ))
            .getSingleOrNull();
    if (row == null) {
      return null;
    }
    return DateTime.tryParse(row.value);
  }

  Future<void> setLastFetchedAt(final DateTime time) async {
    await into(rankingMetadataTable).insert(
      RankingMetadataTableCompanion.insert(
        key: 'last_fetched_at',
        value: time.toIso8601String(),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'turskyi_ranking_db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        onResult: (final WasmDatabaseResult result) {
          if (result.missingFeatures.isNotEmpty && kDebugMode) {
            debugPrint(
              'Drift Web using ${result.chosenImplementation} due to '
              'unsupported browser features: ${result.missingFeatures}',
            );
          }
        },
      ),
    );
  }
}
