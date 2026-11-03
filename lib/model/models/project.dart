import 'package:turskyi/model/models/project_ranking.dart';
import 'package:turskyi/model/platform_type.dart';

class Project {
  const Project({
    required this.id,
    required this.name,
    required this.imageAssetPath,
    required this.primaryWebsiteUrl,
    required this.supportedPlatforms,
    this.fallbackWebsiteUrl = '',
    this.ranking,
  });

  final String id;
  final String name;
  final String imageAssetPath;
  final String primaryWebsiteUrl;
  final String fallbackWebsiteUrl;
  final Set<PlatformType> supportedPlatforms;

  /// Dynamic lifetime download and user ranking
  /// statistics for this project.
  ///
  /// **Legitimate condition when null:**
  /// - During a cold app start before cached
  ///   rankings from Drift or fresh network
  ///   rankings from backend are loaded.
  /// - If ranking data is unavailable.
  ///
  /// **What happens when null:**
  /// - Falls back to default hardcoded order.
  /// - Platform user count badges are hidden.
  ///
  /// **How it is used:**
  /// - Used by [HomePresenter] to sort projects
  ///   descending by total lifetime users.
  /// - Used by [ProjectTile] to display
  ///   platform download badges.
  final ProjectRanking? ranking;

  bool get isUniversal {
    return supportedPlatforms.containsAll(PlatformType.values.toSet());
  }

  Project copyWithRanking(final ProjectRanking? ranking) {
    return Project(
      id: id,
      name: name,
      imageAssetPath: imageAssetPath,
      primaryWebsiteUrl: primaryWebsiteUrl,
      supportedPlatforms: supportedPlatforms,
      fallbackWebsiteUrl: fallbackWebsiteUrl,
      ranking: ranking,
    );
  }
}
