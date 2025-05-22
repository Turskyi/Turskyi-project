import 'package:turskyi/model/models/project.dart';
import 'package:turskyi/model/platform_type.dart';
import 'package:turskyi/res/constants.dart' as constants;

class ProjectDataSource {
  const ProjectDataSource();

  List<Project> get allProjects {
    return <Project>[
      const Project(
        name: 'Ethical Scanner',
        imageAssetPath: '${constants.featureGraphicPath}'
            'ethical_scanner-feature_graphic.png',
        primaryWebsiteUrl: 'https://ethical-scanner.com',
        fallbackWebsiteUrl: 'https://ethical-scanner-web.vercel.app',
        supportedPlatforms: <PlatformType>{
          PlatformType.ios,
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: 'Life-Coaching AI',
        imageAssetPath: '${constants.featureGraphicPath}'
            'life-coaching_ai-feature_graphic.png',
        primaryWebsiteUrl: 'https://lifecoach.turskyi.com',
        fallbackWebsiteUrl: 'https://life-coaching-ai.vercel.app',
        supportedPlatforms: <PlatformType>{
          PlatformType.ios,
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: 'Daoism - Laozi AI',
        imageAssetPath: '${constants.featureGraphicPath}'
            'daoism_laozi_ai-feature_graphic.png',
        primaryWebsiteUrl: 'https://daoizm.online',
        fallbackWebsiteUrl: 'https://laozi-chatbot.vercel.app',
        supportedPlatforms: <PlatformType>{
          PlatformType.ios,
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: 'WeatherFit',
        imageAssetPath:
            '${constants.featureGraphicPath}weather_fit-feature_graphic.png',
        primaryWebsiteUrl: 'https://weather-fit.com',
        fallbackWebsiteUrl: 'https://weather-fit-ai.web.app',
        supportedPlatforms: <PlatformType>{
          PlatformType.ios,
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: 'Мала Книжка (Тарас Шевченко)',
        imageAssetPath:
            '${constants.featureGraphicPath}mala_knyzhka-feature_graphic.png',
        primaryWebsiteUrl: 'https://mala-knyzhka.web.app',
        // Same as `primaryWebsiteUrl`, because I did not buy the website.
        fallbackWebsiteUrl: '${constants.googlePlayBaseUrl}'
            'com.turskyi.malaknyzhka',
        supportedPlatforms: <PlatformType>{
          PlatformType.android,
          PlatformType.web,
        },
      ),
    ];
  }
}
