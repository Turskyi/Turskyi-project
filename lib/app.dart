import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/home/home_page.dart';

/// [PersonalWebsiteApp] contains main settings of the web page and returns
/// [MaterialApp] with all project specific instructions
class PersonalWebsiteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: translate('title'),
      initialRoute: '/',
      routes: <String, Widget Function(BuildContext)>{
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primarySwatch: AppConfigs.of(context).colors.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
