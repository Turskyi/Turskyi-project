import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/home/home_page.dart';

class PersonalWebsiteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: translate('title'),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomePage(),
      },
      theme: ThemeData(
        primarySwatch: AppConfigs.of(context).colors.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
