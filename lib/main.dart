import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/utils/app_colors.dart';

import 'home/home_page.dart';

const _title = 'title';

void main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: "en", supportedLocales: ["en"]);
  runApp(LocalizedApp(delegate, PersonalWebsiteApp()));
}

class PersonalWebsiteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: translate(_title),
      theme: ThemeData(
        primarySwatch: AppColors.colorPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
