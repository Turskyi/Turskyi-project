import 'package:flutter_translate/flutter_translate.dart';
import 'package:material_ui/material_ui.dart';
import 'package:turskyi/model/ports/app_locale_port.dart';
import 'package:turskyi/res/language.dart';

class FlutterTranslateAppLocalePort implements AppLocalePort {
  const FlutterTranslateAppLocalePort({required this.localizationDelegate});

  final LocalizationDelegate localizationDelegate;

  @override
  Language get currentLanguage => Language.fromIsoLanguageCode(
    localizationDelegate.currentLocale.languageCode,
  );

  @override
  void applyLanguage(final Language language) {
    final Locale locale = localeFromString(language.isoLanguageCode);

    localizationDelegate.changeLocale(locale);
    localizationDelegate.onLocaleChanged?.call(locale);
  }
}
