import 'package:turskyi/model/models/project.dart';
import 'package:turskyi/model/platform_type.dart';
import 'package:turskyi/res/constants.dart' as constants;

class ProjectDataSource {
  const ProjectDataSource();

  List<Project> get allProjects {
    return <Project>[
      const Project(
        name: 'WeatherFit',
        imageAssetPath:
            '${constants.featureGraphicPath}weather_fit-feature_graphic.png',
        primaryWebsiteUrl: 'https://weather-fit.com',
        fallbackWebsiteUrl: 'https://weather.turskyi.com',
        supportedPlatforms: <PlatformType>{
          PlatformType.ios,
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: 'Ethical Scanner',
        imageAssetPath: '${constants.featureGraphicPath}'
            'ethical_scanner-feature_graphic.png',
        primaryWebsiteUrl: 'https://ethical-scanner.com',
        fallbackWebsiteUrl: 'https://ethical-scanner.turskyi.com',
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
        primaryWebsiteUrl: 'https://lifecoaching-ai.com',
        // No `fallbackWebsiteUrl` because it will not support authentication
        // on another domain.
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
        name: 'Politer AI',
        imageAssetPath: '${constants.featureGraphicPath}'
            'politer_ai-feature_graphic.png',
        primaryWebsiteUrl: 'https://www.politerai.com',
        fallbackWebsiteUrl: 'https://politer.turskyi.com',
        supportedPlatforms: <PlatformType>{
          PlatformType.ios,
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: 'InvestTracks',
        imageAssetPath: '${constants.featureGraphicPath}'
            'invest_track-feature_graphic.png',
        primaryWebsiteUrl: 'https://investtracks.com',
        // No `fallbackWebsiteUrl` because it will not support authentication
        // on another domain.
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
        fallbackWebsiteUrl: '${constants.googlePlayBaseUrl}'
            'com.turskyi.malaknyzhka',
        supportedPlatforms: <PlatformType>{
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: 'News Glance',
        imageAssetPath:
            '${constants.featureGraphicPath}news_glance-feature_graphic.png',
        primaryWebsiteUrl: 'https://news.turskyi.com',
        fallbackWebsiteUrl: 'https://news-glanceai.vercel.app',
        supportedPlatforms: <PlatformType>{
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: 'PortionControl',
        imageAssetPath: '${constants.featureGraphicPath}'
            'portion_control-feature_graphic.png',
        primaryWebsiteUrl: 'https://portion-control.turskyi.com',
        fallbackWebsiteUrl: 'https://portion-control-tracker.web.app',
        supportedPlatforms: <PlatformType>{
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: "Anna's Artistic Store",
        imageAssetPath:
            '${constants.featureGraphicPath}anartist_store-feature_graphic.png',
        primaryWebsiteUrl: 'https://anartist.turskyi.com',
        fallbackWebsiteUrl: 'https://an-artist-art.vercel.app',
        supportedPlatforms: <PlatformType>{
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: 'Travelling',
        imageAssetPath:
            '${constants.featureGraphicPath}travelling-feature_graphic.png',
        primaryWebsiteUrl: 'https://travelling.turskyi.com',
        fallbackWebsiteUrl:
            '${constants.googlePlayBaseUrl}io.github.turskyi.travellingpro',
        supportedPlatforms: <PlatformType>{PlatformType.android},
      ),
      const Project(
        name: 'Відчуття.Тиші & Zigmund Afraid',
        imageAssetPath: '${constants.featureGraphicPath}vt-feature_graphic.png',
        primaryWebsiteUrl:
            '${constants.googlePlayBaseUrl}com.music.android.sensilence',
        supportedPlatforms: <PlatformType>{PlatformType.android},
      ),
    ];
  }
}
