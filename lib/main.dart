import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/di/dependencies.dart';
import 'package:turskyi/di/injector.dart' as di;
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/res/configs/builds/main/main_colors.dart';
import 'package:turskyi/res/configs/builds/main/main_configs.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/view/app.dart';
import 'package:turskyi/view/routes/routes.dart' as router;

/// Justification of using the 'async' after [main]
/// is taken from the official documentation at
/// https://pub.dev/packages/flutter_translate/example and as an exception
/// in dart style https://dart-lang.github.io/linter/lints/avoid_void_async.html
void main() async {
  // We need to call `WidgetsFlutterBinding.ensureInitialized` before any
  // `await` operation, otherwise app may stuck on black/white screen.
  WidgetsFlutterBinding.ensureInitialized();

  final Dependencies dependencies = await di.injectDependencies();
  final LocalDataSource localDataSource = dependencies.localDataSource;

  final MainConfigs configs = dependencies.mainConfigs;

  await dependencies.initializeAppLanguageUseCase.call();

  final LocalizationDelegate localizationDelegate =
      dependencies.localizationDelegate;

  // Routes of all pages of the app.
  final Map<String, WidgetBuilder> routes = router.getRouteMap(localDataSource);

  runApp(
    LocalizedApp(
      localizationDelegate,
      Configs(
        configs: configs,
        colors: MainColors(),
        child: App(routes: routes),
      ),
    ),
  );
}
