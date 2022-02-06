import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/routes.dart';
import 'package:turskyi/presentation/values/app_styles.dart';
import 'package:turskyi/presentation/views/game/game_page.dart';
import 'package:turskyi/presentation/views/home/home_page.dart';

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
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      routes: <String, Widget Function(BuildContext)>{
        Routes.home: (BuildContext context) => const HomePage(),
        Routes.game: (BuildContext context) => const GamePage(),
      },
      theme: ThemeData(
        primarySwatch: AppConfigs.of(context).colors.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          headline6: AppStyles.headline6,
          headline5: AppStyles.headline5,
          headline4: AppStyles.headline4,
          headline3: AppStyles.headline3,
        ),
      ),
    );
  }
}
