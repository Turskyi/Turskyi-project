// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/configs/builds/main/main_colors.dart';
import 'package:turskyi/presentation/configs/builds/main/main_configs.dart';
import 'package:turskyi/presentation/constants.dart';
import 'package:turskyi/setup.dart';

Future<void> main() async {
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: Constants.COUNTRY_CODE_DEFAULT,
    supportedLocales: [Constants.COUNTRY_CODE_DEFAULT],
  );

  var configs = MainConfigs();

  runApp(LocalizedApp(
    delegate,
    AppConfigs(
      configs: configs,
      colors: MainColors(),
      child: setup(configs),
    ),
  ));
}
