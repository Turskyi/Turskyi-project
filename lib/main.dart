import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/domain/language.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/configs/builds/main/main_colors.dart';
import 'package:turskyi/presentation/configs/builds/main/main_configs.dart';
import 'package:turskyi/setup.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  /// init language
  final LocalizationDelegate delegate = await LocalizationDelegate.create(
    fallbackLocale: Language.en.code,
    supportedLocales: <String>[Language.en.code],
  );

  final MainConfigs configs = MainConfigs();

  /* Here we set the URL strategy for our web app. It is safe to call
     * this function when running on mobile or desktop as well.*/
  setPathUrlStrategy();

  /// start project
  runApp(LocalizedApp(
    delegate,
    AppConfigs(configs: configs, colors: MainColors(), child: setup(configs)),
  ));
}
