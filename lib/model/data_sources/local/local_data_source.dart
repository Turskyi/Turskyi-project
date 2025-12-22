import 'package:flutter/foundation.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turskyi/model/models/project.dart';
import 'package:turskyi/model/platform_type.dart';
import 'package:turskyi/res/constants.dart' as constants;
import 'package:turskyi/res/enums/settings.dart';
import 'package:turskyi/res/language.dart';
import 'package:turskyi/view/routes/app_route.dart';

class LocalDataSource {
  const LocalDataSource(this._preferences);

  final SharedPreferences _preferences;

  Future<bool> saveLanguageIsoCode(String languageIsoCode) {
    final bool isSupported = Language.values.any(
      (Language lang) => lang.isoLanguageCode == languageIsoCode,
    );

    final String safeLanguageCode = isSupported
        ? languageIsoCode
        : Language.en.isoLanguageCode;

    return _preferences.setString(
      Settings.languageIsoCode.key,
      safeLanguageCode,
    );
  }

  String getLanguageIsoCode() {
    final String? savedLanguageIsoCode = _preferences.getString(
      Settings.languageIsoCode.key,
    );

    final bool isSavedLanguageSupported =
        savedLanguageIsoCode != null &&
        Language.values.any(
          (Language lang) => lang.isoLanguageCode == savedLanguageIsoCode,
        );

    final String systemLanguageCode =
        PlatformDispatcher.instance.locale.languageCode;

    String defaultLanguageCode =
        Language.values.any(
          (Language lang) => lang.isoLanguageCode == systemLanguageCode,
        )
        ? systemLanguageCode
        : Language.en.isoLanguageCode;

    // Retrieves the host name (e.g., "localhost" or "uk.turskyi.com").
    final String host = Uri.base.host;

    // Retrieves the fragment (e.g., "/en" or "/uk").
    final String fragment = Uri.base.fragment;

    for (final Language language in Language.values) {
      final String currentLanguageCode = language.isoLanguageCode;

      if (host.startsWith('$currentLanguageCode.') ||
          fragment.contains('${AppRoute.home.path}$currentLanguageCode')) {
        try {
          Intl.defaultLocale = currentLanguageCode;
        } catch (e, stackTrace) {
          debugPrint(
            'Failed to set Intl.defaultLocale to "$currentLanguageCode".\n'
            'Error: $e\n'
            'StackTrace: $stackTrace\n'
            'Proceeding with previously set default locale or system default.',
          );
        }
        defaultLanguageCode = currentLanguageCode;
        // Exit the loop once a match is found and processed.
        break;
      }
    }

    return isSavedLanguageSupported
        ? savedLanguageIsoCode
        : defaultLanguageCode;
  }

  Language getSavedLanguage() {
    final String savedLanguageIsoCode = getLanguageIsoCode();
    final Language savedLanguage = Language.fromIsoLanguageCode(
      savedLanguageIsoCode,
    );
    return savedLanguage;
  }

  List<Project> get allProjects {
    return <Project>[
      Project(
        name: translate('projects.weather_fit.name'),
        imageAssetPath:
            '${constants.kFeatureGraphicPath}weather_fit-feature_graphic.png',
        primaryWebsiteUrl: translate('projects.weather_fit.url'),
        fallbackWebsiteUrl: translate('projects.weather_fit.fallback_url'),
        supportedPlatforms: <PlatformType>{
          PlatformType.ios,
          PlatformType.android,
          PlatformType.web,
        },
      ),
      Project(
        name: translate('projects.ethical_scanner.name'),
        imageAssetPath:
            '${constants.kFeatureGraphicPath}'
            'ethical_scanner-feature_graphic.png',
        primaryWebsiteUrl: translate('projects.ethical_scanner.url'),
        fallbackWebsiteUrl: 'https://ethical-scanner.turskyi.com',
        supportedPlatforms: <PlatformType>{
          PlatformType.ios,
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: 'Life-Coaching AI',
        imageAssetPath:
            '${constants.kFeatureGraphicPath}'
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
        imageAssetPath:
            '${constants.kFeatureGraphicPath}'
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
        imageAssetPath:
            '${constants.kFeatureGraphicPath}'
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
        imageAssetPath:
            '${constants.kFeatureGraphicPath}'
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
        name: 'PortionControl',
        imageAssetPath:
            '${constants.kFeatureGraphicPath}'
            'portion_control-feature_graphic.png',
        primaryWebsiteUrl: 'https://portion-control.turskyi.com',
        fallbackWebsiteUrl: 'https://portion-control-tracker.web.app',
        supportedPlatforms: <PlatformType>{
          PlatformType.android,
          PlatformType.web,
          PlatformType.ios,
        },
      ),
      const Project(
        name: 'Мала Книжка (Тарас Шевченко)',
        imageAssetPath:
            '${constants.kFeatureGraphicPath}mala_knyzhka-feature_graphic.png',
        primaryWebsiteUrl: 'https://mala-knyzhka.web.app',
        fallbackWebsiteUrl:
            '${constants.kGooglePlayBaseUrl}'
            'com.turskyi.malaknyzhka',
        supportedPlatforms: <PlatformType>{
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: 'News Glance',
        imageAssetPath:
            '${constants.kFeatureGraphicPath}news_glance-feature_graphic.png',
        primaryWebsiteUrl: 'https://news.turskyi.com',
        fallbackWebsiteUrl: 'https://news-glanceai.vercel.app',
        supportedPlatforms: <PlatformType>{
          PlatformType.android,
          PlatformType.web,
        },
      ),
      const Project(
        name: "Anna's Artistic Store",
        imageAssetPath:
            '${constants.kFeatureGraphicPath}'
            'anartist_store-feature_graphic.png',
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
            '${constants.kFeatureGraphicPath}travelling-feature_graphic.png',
        primaryWebsiteUrl: 'https://travelling.turskyi.com',
        fallbackWebsiteUrl:
            '${constants.kGooglePlayBaseUrl}io.github.turskyi.travellingpro',
        supportedPlatforms: <PlatformType>{PlatformType.android},
      ),
      const Project(
        name: 'Відчуття.Тиші & Zigmund Afraid',
        imageAssetPath:
            '${constants.kFeatureGraphicPath}vt-feature_graphic.png',
        primaryWebsiteUrl:
            '${constants.kGooglePlayBaseUrl}com.music.android.sensilence',
        supportedPlatforms: <PlatformType>{PlatformType.android},
      ),
    ];
  }
}
