import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:resend/resend.dart';
import 'package:turskyi/env/env.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/values/themes.dart';
import 'package:turskyi/view/routes/app_route.dart';

/// [App] contains main settings of the web page and returns
/// [MaterialApp] with all project specific instructions
class App extends StatelessWidget {
  /// It's a good practice to expose the ability to provide a key
  /// when creating public widgets.
  const App({required this.routes, super.key});

  final Map<String, WidgetBuilder> routes;

  @override
  Widget build(BuildContext context) {
    Resend(apiKey: Env.resendApiKey);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: translate('title'),
      initialRoute: AppRoute.home.path,
      routes: routes,
      theme: ThemeData(
        primarySwatch: Configs.of(context).colors.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Themes.textTheme.apply(
          // Light grey.
          bodyColor: Colors.grey.shade300,
          // Very light grey.
          displayColor: Colors.grey.shade100,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            // Medium grey.
            backgroundColor: Colors.grey.shade500,
            // Light grey for text.
            foregroundColor: Colors.grey.shade100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: Themes.textTheme.titleMedium,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          // Light grey.
          cursorColor: Colors.grey.shade100,
          // a bit darker grey.
          selectionColor: Colors.grey.shade400,
          //light grey.
          selectionHandleColor: Colors.grey.shade100,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          // Light grey for the indicator.
          color: Colors.grey.shade100,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          // Medium grey.
          backgroundColor: Colors.grey.shade500,
          // Light grey for icon.
          foregroundColor: Colors.grey.shade100,
        ),
        // the background of the Scaffold.
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}
