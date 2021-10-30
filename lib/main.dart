import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/domain/language.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/configs/builds/main/main_colors.dart';
import 'package:turskyi/presentation/configs/builds/main/main_configs.dart';
import 'package:turskyi/setup.dart';

Future<void> main() async {
  /// init language
  final LocalizationDelegate localizationDelegate =
      await LocalizationDelegate.create(
    fallbackLocale: Language.en.code,
    supportedLocales: <String>[Language.en.code],
  );

  final MainConfigs configs = MainConfigs();

  /// start project
  runApp(LocalizedApp(
    localizationDelegate,
    AppConfigs(configs: configs, colors: MainColors(), child: setup(configs)),
  ));
}
