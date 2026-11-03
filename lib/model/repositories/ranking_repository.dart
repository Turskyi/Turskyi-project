import 'package:flutter/foundation.dart';
import 'package:turskyi/model/data_sources/local/database/ranking_database.dart';
import 'package:turskyi/model/data_sources/remote/support_api_client.dart';
import 'package:turskyi/model/models/app_ranking_dto.dart';
import 'package:turskyi/model/models/project_ranking.dart';
import 'package:turskyi/model/models/ranking_response.dart';

class RankingRepository {
  const RankingRepository({
    required final RankingDatabase database,
    required final SupportApiClient apiClient,
  }) : _database = database,
       _apiClient = apiClient;

  final RankingDatabase _database;
  final SupportApiClient _apiClient;

  /// Returns cached rankings immediately from Drift database.
  Future<List<ProjectRanking>> getCachedRankings() {
    return _database.getAllRankings();
  }

  /// Checks if local cache is stale (> 7 days or missing).
  Future<bool> isCacheStale() async {
    final DateTime? lastFetched = await _database.getLastFetchedAt();
    if (lastFetched == null) {
      return true;
    } else {
      return DateTime.now().difference(lastFetched) >= const Duration(days: 7);
    }
  }

  /// Fetches fresh ranking data from backend `/ranking`, updates Drift database,
  /// and returns fresh list of [ProjectRanking]s.
  Future<List<ProjectRanking>> fetchAndSaveRankings() async {
    try {
      final RankingResponse response = await _apiClient.fetchRanking();
      final DateTime fetchTime =
          DateTime.tryParse(response.updatedAt) ?? DateTime.now();

      final List<ProjectRanking> rankings = response.apps.map((
        final AppRankingDto dto,
      ) {
        return ProjectRanking(
          id: dto.id,
          total: dto.total,
          ios: dto.ios,
          android: dto.android,
          web: dto.web,
          updatedAt: fetchTime,
        );
      }).toList();

      await _database.saveRankings(rankings);
      await _database.setLastFetchedAt(DateTime.now());

      return rankings;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('Failed to fetch project rankings from backend: $e');
        debugPrint('Stack trace: $stackTrace');
      }
      return _database.getAllRankings();
    }
  }
}
