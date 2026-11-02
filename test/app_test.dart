import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turskyi/localization/localization_delegate_getter.dart'
    as locale;
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/res/configs/builds/main/main_colors.dart';
import 'package:turskyi/res/configs/builds/main/main_configs.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/view/app.dart';
import 'package:turskyi/view/pages/game/unity_three_d_game_page.dart';
import 'package:turskyi/view/pages/game/unity_two_d_game_page.dart';
import 'package:turskyi/view/pages/home/home_page.dart';
import 'package:turskyi/view/pages/home/widgets/project_tile.dart';
import 'package:turskyi/view/pages/home/widgets/projects_button.dart';
import 'package:turskyi/view/pages/support/support_page.dart';
import 'package:turskyi/view/routes/app_route.dart';

void main() {
  testWidgets('App renders home screen', (final WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});

    /// Init language.
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final LocalDataSource localDataSource = LocalDataSource(preferences);

    final LocalizationDelegate localizationDelegate = await locale
        .getLocalizationDelegate(localDataSource);

    // 💡 Force test to have larger physical screen
    tester.view.physicalSize = const Size(1024, 2500);
    tester.view.devicePixelRatio = 1.0;
    // Routes of all pages of the app.
    final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
      AppRoute.home.path: (BuildContext _) {
        return HomePage(localDataSource: LocalDataSource(preferences));
      },
      AppRoute.game.path: (BuildContext _) => const UnityThreeDGamePage(),
      AppRoute.unityGame.path: (BuildContext _) => const UnityTwoDGamePage(),
      AppRoute.support.path: (BuildContext _) => const SupportPage(),
    };
    final LocalizedApp testWidget = LocalizedApp(
      localizationDelegate,
      Configs(
        configs: MainConfigs(),
        colors: MainColors(),
        child: App(routes: routes),
      ),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    expect(find.textContaining('Dmytro'), findsOneWidget);

    // 🧹 Clean up afterwards to avoid affecting other tests
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets('Daoism tile receives pointer input over home content', (
    final WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final LocalDataSource localDataSource = LocalDataSource(preferences);
    final LocalizationDelegate localizationDelegate = await locale
        .getLocalizationDelegate(localDataSource);

    tester.view.physicalSize = const Size(800, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
      AppRoute.home.path: (BuildContext _) =>
          HomePage(localDataSource: localDataSource),
      AppRoute.game.path: (BuildContext _) => const UnityThreeDGamePage(),
      AppRoute.unityGame.path: (BuildContext _) => const UnityTwoDGamePage(),
      AppRoute.support.path: (BuildContext _) => const SupportPage(),
    };
    await tester.pumpWidget(
      LocalizedApp(
        localizationDelegate,
        Configs(
          configs: MainConfigs(),
          colors: MainColors(),
          child: App(routes: routes),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ProjectsButton));
    await tester.pumpAndSettle();

    final Finder daoismTile = find.byWidgetPredicate(
      (final Widget widget) =>
          widget is ProjectTile &&
          widget.project.imageAssetPath.endsWith(
            'daoism_laozi_ai-feature_graphic.png',
          ),
    );
    await Scrollable.ensureVisible(
      daoismTile.evaluate().single,
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    final Rect tileBounds = tester.getRect(daoismTile);
    final Offset coveredTilePoint = Offset(
      tileBounds.left + 30,
      tileBounds.center.dy,
    );
    final Finder tileMouseRegionFinder = find.descendant(
      of: daoismTile,
      matching: find.byType(MouseRegion),
    );
    expect(tileMouseRegionFinder, findsOneWidget);

    final RenderMouseRegion tileMouseRegion = tester.renderObject(
      tileMouseRegionFinder,
    );
    final HitTestResult hitTestResult = tester.hitTestOnBinding(
      coveredTilePoint,
    );
    expect(
      hitTestResult.path.any(
        (final HitTestEntry entry) => identical(entry.target, tileMouseRegion),
      ),
      isTrue,
    );
  });
}
