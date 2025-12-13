import 'package:flutter/material.dart';
import 'package:turskyi/model/project_data_source.dart';
import 'package:turskyi/view/pages/game/unity_three_d_game_page.dart';
import 'package:turskyi/view/pages/game/unity_two_d_game_page.dart';
import 'package:turskyi/view/pages/home/home_page.dart';
import 'package:turskyi/view/pages/support/support_page.dart';
import 'package:turskyi/view/routes/app_route.dart';

/// Util method for storing routes of all pages of the app.
Map<String, WidgetBuilder> get routes {
  return <String, WidgetBuilder>{
    AppRoute.home.path: (BuildContext _) {
      return const HomePage(projectDataSource: ProjectDataSource());
    },
    AppRoute.game.path: (BuildContext _) => const UnityThreeDGamePage(),
    AppRoute.unityGame.path: (BuildContext _) => const UnityTwoDGamePage(),
    AppRoute.support.path: (BuildContext _) => const SupportPage(),
  };
}
