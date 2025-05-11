import 'package:turskyi/model/platform_type.dart';

class Project {
  const Project({
    required this.name,
    required this.imageAssetPath,
    required this.websiteUrl,
    required this.supportedPlatforms,
  });

  final String name;
  final String imageAssetPath;
  final String websiteUrl;
  final Set<PlatformType> supportedPlatforms;

  bool get isUniversal {
    return supportedPlatforms.containsAll(PlatformType.values.toSet());
  }
}
