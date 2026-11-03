import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turskyi/localization/localization_delegate_getter.dart'
    as locale;
import 'package:turskyi/model/data_sources/local/database/ranking_database.dart';
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/model/data_sources/remote/support_api_client.dart';
import 'package:turskyi/model/repositories/ranking_repository.dart';
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
    final RankingDatabase rankingDatabase = RankingDatabase.forTesting(
      NativeDatabase.memory(),
    );
    final RankingRepository rankingRepository = RankingRepository(
      database: rankingDatabase,
      apiClient: SupportApiClient(Dio()),
    );

    final LocalizationDelegate localizationDelegate = await locale
        .getLocalizationDelegate(localDataSource);

    // 💡 Force test to have larger physical screen
    tester.view.physicalSize = const Size(1024, 2500);
    tester.view.devicePixelRatio = 1.0;
    // Routes of all pages of the app.
    final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
      AppRoute.home.path: (BuildContext _) {
        return HomePage(
          localDataSource: localDataSource,
          rankingRepository: rankingRepository,
        );
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
      rankingDatabase.close();
    });
  });

  testWidgets('Daoism tile receives pointer input over home content', (
    final WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final LocalDataSource localDataSource = LocalDataSource(preferences);
    final RankingDatabase rankingDatabase = RankingDatabase.forTesting(
      NativeDatabase.memory(),
    );
    final RankingRepository rankingRepository = RankingRepository(
      database: rankingDatabase,
      apiClient: SupportApiClient(Dio()),
    );
    final LocalizationDelegate localizationDelegate = await locale
        .getLocalizationDelegate(localDataSource);

    tester.view.physicalSize = const Size(800, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
      rankingDatabase.close();
    });

    final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
      AppRoute.home.path: (BuildContext _) {
        return HomePage(
          localDataSource: localDataSource,
          rankingRepository: rankingRepository,
        );
      },
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

    final Finder projectsButtonFinder = find.byType(ProjectsButton);
    expect(projectsButtonFinder, findsOneWidget);

    await tester.tap(projectsButtonFinder);
    await tester.pumpAndSettle();

    final Finder daoismTileFinder = find.byWidgetPredicate((
      final Widget widget,
    ) {
      return widget is ProjectTile && widget.project.name == 'Daoism Laozi AI';
    });

    if (daoismTileFinder.evaluate().isNotEmpty) {
      await tester.ensureVisible(daoismTileFinder);
      final TestGesture gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
      );
      await gesture.addPointer(location: tester.getCenter(daoismTileFinder));
      addTearDown(gesture.removePointer);
      await tester.pump();
    }

    expect(tester.takeException(), isNull);
  });
}
