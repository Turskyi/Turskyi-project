import 'package:flutter_test/flutter_test.dart';
import 'package:turskyi/model/models/project.dart';
import 'package:turskyi/model/platform_type.dart';

void main() {
  group('Project model', () {
    test('sortedSupportedPlatforms returns platforms in enum order', () {
      const Project project = Project(
        id: 'test_project',
        name: 'Test Project',
        imageAssetPath: 'assets/test.png',
        primaryWebsiteUrl: 'https://example.com',
        supportedPlatforms: <PlatformType>{
          PlatformType.web,
          PlatformType.ios,
          PlatformType.android,
        },
      );

      expect(project.sortedSupportedPlatforms, <PlatformType>[
        PlatformType.android,
        PlatformType.ios,
        PlatformType.web,
      ]);
    });

    test('isUniversal returns true when all platforms supported', () {
      const Project project = Project(
        id: 'universal_project',
        name: 'Universal Project',
        imageAssetPath: 'assets/test.png',
        primaryWebsiteUrl: 'https://example.com',
        supportedPlatforms: <PlatformType>{
          PlatformType.android,
          PlatformType.ios,
          PlatformType.web,
        },
      );

      expect(project.isUniversal, isTrue);
    });
  });
}
