import 'dart:math' as math;

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

  /// Fetches fresh ranking data from backend `/ranking`,
  /// updates Drift database, and returns fresh list of [ProjectRanking]s.
  ///
  /// **Monotonic Metric Protection:** Ensures that if an incoming network
  /// metric temporarily drops to 0 due to a transient upstream API timeout or
  /// outage, the higher cached metric is preserved so user counts never
  /// regress.
  Future<List<ProjectRanking>> fetchAndSaveRankings() async {
    try {
      final RankingResponse response = await _apiClient.fetchRanking();
      final DateTime fetchTime =
          DateTime.tryParse(response.updatedAt) ?? DateTime.now();

      final List<ProjectRanking> cachedRankings = await _database
          .getAllRankings();
      final Map<String, ProjectRanking> cachedMap = <String, ProjectRanking>{
        for (final ProjectRanking r in cachedRankings) r.id: r,
      };

      final List<ProjectRanking> rankings = response.apps.map((
        final AppRankingDto dto,
      ) {
        final ProjectRanking? existing = cachedMap[dto.id];
        final int ios = math.max(existing?.ios ?? 0, dto.ios);
        final int android = math.max(existing?.android ?? 0, dto.android);
        final int web = math.max(existing?.web ?? 0, dto.web);
        final int total = ios + android + web;

        return ProjectRanking(
          id: dto.id,
          total: total,
          ios: ios,
          android: android,
          web: web,
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
