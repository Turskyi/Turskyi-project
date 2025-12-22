import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turskyi/localization/localization_delelegate_getter.dart'
    as locale;
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/res/configs/builds/main/main_colors.dart';
import 'package:turskyi/res/configs/builds/main/main_configs.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/language.dart';
import 'package:turskyi/view/app.dart';

/// Justification of using the 'async' after [main]
/// is taken from the official documentation at
/// https://pub.dev/packages/flutter_translate/example and as an exception
/// in dart style https://dart-lang.github.io/linter/lints/avoid_void_async.html
void main() async {
  // We need to call `WidgetsFlutterBinding.ensureInitialized` before any
  // `await` operation, otherwise app may stuck on black/white screen.
  WidgetsFlutterBinding.ensureInitialized();

  /// Init language.
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  final LocalDataSource localDataSource = LocalDataSource(preferences);

  final Language savedLanguage = localDataSource.getSavedLanguage();

  final LocalizationDelegate localizationDelegate = await locale
      .getLocalizationDelegate(localDataSource);

  final Language currentLanguage = Language.fromIsoLanguageCode(
    localizationDelegate.currentLocale.languageCode,
  );

  if (savedLanguage != currentLanguage) {
    final Locale locale = localeFromString(savedLanguage.isoLanguageCode);

    localizationDelegate.changeLocale(locale);

    // Notify listeners that the locale has changed so they can update.
    localizationDelegate.onLocaleChanged?.call(locale);
  }

  final MainConfigs configs = MainConfigs();

  runApp(
    LocalizedApp(
      localizationDelegate,
      Configs(configs: configs, colors: MainColors(), child: const App()),
    ),
  );
}
