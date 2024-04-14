import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/main/res/configs/configs.dart';
import 'package:turskyi/main/res/values/themes.dart';
import 'package:turskyi/view/routes/app_route.dart';
import 'package:turskyi/view/routes/app_router.dart';

/// [App] contains main settings of the web page and returns
/// [MaterialApp] with all project specific instructions
class App extends StatelessWidget {
  /// It's a good practice to expose the ability to provide a key
  /// when creating public widgets.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: translate('title'),
      initialRoute: AppRoute.home.path,
      routes: AppRouter.routes,
      theme: ThemeData(
        primarySwatch: Configs.of(context).colors.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Themes.textTheme,
      ),
    );
  }
}
