import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/domain/language.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';
import 'package:turskyi/presentation/configs/builds/main/main_colors.dart';
import 'package:turskyi/presentation/configs/builds/main/main_configs.dart';
import 'package:turskyi/setup.dart';

/// Justification of using the 'async' after [main]
/// is taken from the official documentation at
/// https://pub.dev/packages/flutter_translate/example.
Future<void> main() async {
  /// init language
  final LocalizationDelegate localizationDelegate =
      await LocalizationDelegate.create(
    fallbackLocale: Language.en.name,
    supportedLocales: <String>[Language.en.name],
  );

  final MainConfigs configs = MainConfigs();

  runApp(
    LocalizedApp(
      localizationDelegate,
      AppConfigs(configs: configs, colors: MainColors(), child: setup(configs)),
    ),
  );
}
