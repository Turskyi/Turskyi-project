import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:resend/resend.dart';
import 'package:turskyi/env/env.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/values/themes.dart';
import 'package:turskyi/view/routes/app_route.dart';
import 'package:turskyi/view/routes/app_router.dart' as router;

/// [App] contains main settings of the web page and returns
/// [MaterialApp] with all project specific instructions
class App extends StatelessWidget {
  /// It's a good practice to expose the ability to provide a key
  /// when creating public widgets.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Resend(apiKey: Env.resendApiKey);
    return MaterialApp(
      title: translate('title'),
      initialRoute: AppRoute.home.path,
      routes: router.routes,
      theme: ThemeData(
        primarySwatch: Configs.of(context).colors.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Themes.textTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Configs.of(context).colors.primarySwatch.shade500,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: Themes.textTheme.titleMedium,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white,
        ),
      ),
    );
  }
}
