import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turskyi/localization/localization_delegate_getter.dart'
    as locale;
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/res/configs/builds/main/main_colors.dart';
import 'package:turskyi/res/configs/builds/main/main_configs.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/language.dart';
import 'package:turskyi/view/app.dart';
import 'package:turskyi/view/routes/app_route.dart';
import 'package:turskyi/view/routes/routes.dart' as router;

/// Justification of using the 'async' after [main]
/// is taken from the official documentation at
/// https://pub.dev/packages/flutter_translate/example and as an exception
/// in dart style https://dart-lang.github.io/linter/lints/avoid_void_async.html
void main() async {
  // We need to call `WidgetsFlutterBinding.ensureInitialized` before any
  // `await` operation, otherwise app may stuck on black/white screen.
  WidgetsFlutterBinding.ensureInitialized();

  // Init language.
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  final LocalDataSource localDataSource = LocalDataSource(preferences);

  final MainConfigs configs = MainConfigs();

  Language initialLanguage = localDataSource.getSavedLanguage();

  // Retrieves the host name (e.g., "https://turskyi.com/#/uk").
  initialLanguage = await _resolveInitialLanguageFromUrl(
    initialLanguage: initialLanguage,
    localDataSource: localDataSource,
  );

  final LocalizationDelegate localizationDelegate = await locale
      .getLocalizationDelegate(localDataSource);

  final Language currentLanguage = Language.fromIsoLanguageCode(
    localizationDelegate.currentLocale.languageCode,
  );

  if (initialLanguage != currentLanguage) {
    _applyInitialLocale(
      initialLanguage: initialLanguage,
      localizationDelegate: localizationDelegate,
    );
  }

  // Routes of all pages of the app.
  final Map<String, WidgetBuilder> routes = router.getRouteMap(localDataSource);

  runApp(
    LocalizedApp(
      localizationDelegate,
      Configs(
        configs: configs,
        colors: MainColors(),
        child: App(routes: routes),
      ),
    ),
  );
}

Future<Language> _resolveInitialLanguageFromUrl({
  required Language initialLanguage,
  required LocalDataSource localDataSource,
}) async {
  Language currentLanguage = initialLanguage;
  // Retrieves the host name (e.g., "localhost" or "uk.turskyi.com").
  final String host = Uri.base.host;

  // Retrieves the fragment (e.g., "/en" or "https://turskyi.com/#/uk").
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
      currentLanguage = language;
      // We save it so the rest of the app (like recommendations) uses this
      // language.
      await localDataSource.saveLanguageIsoCode(currentLanguageCode);
      break;
    }
  }
  return currentLanguage;
}

void _applyInitialLocale({
  required Language initialLanguage,
  required LocalizationDelegate localizationDelegate,
}) {
  final Locale locale = localeFromString(initialLanguage.isoLanguageCode);

  localizationDelegate.changeLocale(locale);

  // Notify listeners that the locale has changed so they can update.
  localizationDelegate.onLocaleChanged?.call(locale);
}
