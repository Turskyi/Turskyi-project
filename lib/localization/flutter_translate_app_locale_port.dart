import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
  void applyLanguage(Language language) {
    final Locale locale = localeFromString(language.isoLanguageCode);

    localizationDelegate.changeLocale(locale);
    localizationDelegate.onLocaleChanged?.call(locale);
  }
}
