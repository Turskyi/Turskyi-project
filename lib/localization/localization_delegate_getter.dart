import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/res/language.dart';

Future<LocalizationDelegate> getLocalizationDelegate(
  LocalDataSource localDataSource,
) async {
  final LocalizationDelegate localizationDelegate =
      await LocalizationDelegate.create(
        fallbackLocale: localDataSource.getLanguageIsoCode(),
        supportedLocales: Language.values.map((Language language) {
          return language.isoLanguageCode;
        }).toList(),
      );

  return localizationDelegate;
}
