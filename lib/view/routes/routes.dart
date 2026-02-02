import 'package:flutter/material.dart';
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/view/pages/game/unity_three_d_game_page.dart';
import 'package:turskyi/view/pages/game/unity_two_d_game_page.dart';
import 'package:turskyi/view/pages/home/home_page.dart';
import 'package:turskyi/view/pages/support/support_page.dart';
import 'package:turskyi/view/routes/app_route.dart';

Map<String, WidgetBuilder> getRouteMap(LocalDataSource localDataSource) {
  return <String, WidgetBuilder>{
    AppRoute.home.path: (BuildContext _) {
      return HomePage(localDataSource: localDataSource);
    },
    AppRoute.game.path: (BuildContext _) => const UnityThreeDGamePage(),
    AppRoute.unityGame.path: (BuildContext _) => const UnityTwoDGamePage(),
    AppRoute.support.path: (BuildContext _) => const SupportPage(),
    AppRoute.enHome.path: (BuildContext _) {
      return HomePage(localDataSource: localDataSource);
    },
    AppRoute.ukHome.path: (BuildContext _) {
      return HomePage(localDataSource: localDataSource);
    },
  };
}
