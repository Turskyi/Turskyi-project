import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/routes/app_route.dart';
import 'package:turskyi/presentation/routes/app_router.dart';
import 'package:turskyi/presentation/values/themes.dart';

/// [App] contains main settings of the web page and returns
/// [MaterialApp] with all project specific instructions
class App extends StatelessWidget {
  /// It's a good practice to expose the ability to provide a key
  /// when creating public widgets.
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: translate('title'),
      initialRoute: AppRoute.home.path,
      routes: AppRouter.routes,
      theme: ThemeData(
        primarySwatch: AppConfigs.of(context).colors.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Themes.textTheme,
      ),
    );
  }
}
