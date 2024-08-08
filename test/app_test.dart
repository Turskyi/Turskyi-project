import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/main/res/configs/builds/main/main_colors.dart';
import 'package:turskyi/main/res/configs/builds/main/main_configs.dart';
import 'package:turskyi/main/res/configs/configs.dart';
import 'package:turskyi/view/app.dart';
import 'package:turskyi/view/routes/app_route.dart';

void main() {
  testWidgets('App widget test', (WidgetTester tester) async {
    // Initialize the translation delegate
    final LocalizationDelegate delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en',
      supportedLocales: <String>['en'],
    );

    await tester.pumpWidget(
      LocalizedApp(
        delegate,
        Configs(
          colors: MainColors(),
          configs: MainConfigs(),
          child: const App(),
        ),
      ),
    );

    // Verify the initial route
    expect(find.byType(MaterialApp), findsOneWidget);
    final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));
    expect(materialApp.initialRoute, AppRoute.home.path);

    // Verify the theme
    final ColorScheme? colorScheme = materialApp.theme?.colorScheme;
    expect(
      colorScheme?.primary,
      Configs.of(tester.element(find.byType(MaterialApp))).colors.primarySwatch,
    );
    expect(
      materialApp.theme?.visualDensity,
      VisualDensity.adaptivePlatformDensity,
    );
  });
}
