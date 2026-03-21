import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/src/delegates/localization_delegate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turskyi/localization/flutter_translate_app_locale_port.dart';
import 'package:turskyi/localization/localization_delegate_getter.dart'
    as locale;
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/res/language.dart';

void main() {
  testWidgets('FlutterTranslateAppLocalePort applies selected language', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final LocalDataSource localDataSource = LocalDataSource(preferences);
    final LocalizationDelegate delegate = await locale.getLocalizationDelegate(
      localDataSource,
    );
    final FlutterTranslateAppLocalePort appLocalePort =
        FlutterTranslateAppLocalePort(localizationDelegate: delegate);

    appLocalePort.applyLanguage(Language.uk);
    await tester.pump();

    expect(appLocalePort.currentLanguage, Language.uk);
  });
}
