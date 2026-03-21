import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/model/ports/app_locale_port.dart';
import 'package:turskyi/model/use_cases/initialize_app_language_use_case.dart';
import 'package:turskyi/res/language.dart';

void main() {
  group('InitializeAppLanguageUseCase', () {
    test('applies saved language when current app language differs', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final LocalDataSource localDataSource = LocalDataSource(preferences);
      await localDataSource.saveLanguageIsoCode(Language.uk.isoLanguageCode);

      final FakeAppLocalePort appLocalePort = FakeAppLocalePort(
        currentLanguage: Language.en,
      );
      final InitializeAppLanguageUseCase useCase = InitializeAppLanguageUseCase(
        localDataSource: localDataSource,
        appLocalePort: appLocalePort,
      );

      final Language language = await useCase();

      expect(language, Language.uk);
      expect(appLocalePort.currentLanguage, Language.uk);
      expect(appLocalePort.appliedLanguages, <Language>[Language.uk]);
    });

    test(
      'does not apply language when current app language already matches',
      () async {
        SharedPreferences.setMockInitialValues(<String, Object>{});
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        final LocalDataSource localDataSource = LocalDataSource(preferences);
        await localDataSource.saveLanguageIsoCode(Language.uk.isoLanguageCode);

        final FakeAppLocalePort appLocalePort = FakeAppLocalePort(
          currentLanguage: Language.uk,
        );
        final InitializeAppLanguageUseCase useCase =
            InitializeAppLanguageUseCase(
              localDataSource: localDataSource,
              appLocalePort: appLocalePort,
            );

        final Language language = await useCase();

        expect(language, Language.uk);
        expect(appLocalePort.appliedLanguages, isEmpty);
      },
    );
  });
}

class FakeAppLocalePort implements AppLocalePort {
  FakeAppLocalePort({required Language currentLanguage})
    : _currentLanguage = currentLanguage;

  final List<Language> appliedLanguages = <Language>[];
  Language _currentLanguage;

  @override
  Language get currentLanguage => _currentLanguage;

  @override
  void applyLanguage(Language language) {
    appliedLanguages.add(language);
    _currentLanguage = language;
  }
}
