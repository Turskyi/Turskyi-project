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

  /// Returns [supportedPlatforms] sorted in the canonical order defined by
  /// [PlatformType.values] (i.e., [PlatformType.android], [PlatformType.ios],
  /// [PlatformType.web]).
  ///
  /// **Why ordering in data sources does not matter:**
  /// Regardless of the insertion order of elements in [supportedPlatforms]
  /// within local or remote data sources, this getter evaluates membership
  /// against [PlatformType.values].
  ///
  /// **How the sorting decides the order:**
  /// [PlatformType.values] provides the fixed, canonical order of platforms as
  /// declared in the [PlatformType] enum. Iterating over [PlatformType.values]
  /// and filtering by `supportedPlatforms.contains` produces a deterministic
  /// list ordered strictly by enum index (`android` -> `ios` -> `web`),
  /// ensuring platform icons are displayed consistently across UI components.
  List<PlatformType> get sortedSupportedPlatforms {
    return PlatformType.values.where(supportedPlatforms.contains).toList();
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
