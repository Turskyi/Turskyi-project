import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/res/configs/builds/main/main_colors.dart';
import 'package:turskyi/res/configs/builds/main/main_configs.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/language.dart';
import 'package:turskyi/view/app.dart';

/// Justification of using the 'async' after [main]
/// is taken from the official documentation at
/// https://pub.dev/packages/flutter_translate/example and as an exception
/// in dart style https://dart-lang.github.io/linter/lints/avoid_void_async.html
void main() async {
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
      Configs(configs: configs, colors: MainColors(), child: const App()),
    ),
  );
}
