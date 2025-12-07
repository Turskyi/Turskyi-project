import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/res/configs/builds/main/main_colors.dart';
import 'package:turskyi/res/configs/builds/main/main_configs.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/language.dart';
import 'package:turskyi/view/app.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    final LocalizationDelegate localizationDelegate =
        await LocalizationDelegate.create(
          fallbackLocale: Language.en.name,
          supportedLocales: <String>[Language.en.name],
        );

    // 💡 Force test to have larger physical screen
    tester.view.physicalSize = const Size(1024, 2500);
    tester.view.devicePixelRatio = 1.0;

    final LocalizedApp testWidget = LocalizedApp(
      localizationDelegate,
      Configs(configs: MainConfigs(), colors: MainColors(), child: const App()),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    expect(find.textContaining('Dmytro'), findsOneWidget);

    // 🧹 Clean up afterwards to avoid affecting other tests
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}
