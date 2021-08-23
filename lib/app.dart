import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/routes.dart';
import 'package:turskyi/presentation/views/game/game_page.dart';
import 'package:turskyi/presentation/views/home/home_page.dart';

/// [PersonalWebsiteApp] contains main settings of the web page and returns
/// [MaterialApp] with all project specific instructions
class PersonalWebsiteApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: translate('title'),
      initialRoute: Routes.home,
      routes: <String, Widget Function(BuildContext)>{
        Routes.home: (BuildContext context) => HomePage(),
        Routes.game: (BuildContext context) => GamePage(),
      },
      theme: ThemeData(
        primarySwatch: AppConfigs.of(context).colors.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
