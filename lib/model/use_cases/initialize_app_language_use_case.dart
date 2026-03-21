import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/res/language.dart';
import 'package:turskyi/view/routes/app_route.dart';

class InitializeAppLanguageUseCase {
  const InitializeAppLanguageUseCase({required this.localDataSource});

  final LocalDataSource localDataSource;

  Future<Language> call() async {
    Language currentLanguage = localDataSource.getSavedLanguage();

    final String host = Uri.base.host;
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
        await localDataSource.saveLanguageIsoCode(currentLanguageCode);
        break;
      }
    }

    return currentLanguage;
  }
}
