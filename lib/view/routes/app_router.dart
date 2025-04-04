import 'package:flutter/material.dart';
import 'package:turskyi/view/pages/game/game_page.dart';
import 'package:turskyi/view/pages/game/unity_game_page.dart';
import 'package:turskyi/view/pages/home/home_page.dart';
import 'package:turskyi/view/pages/support/support_page.dart';
import 'package:turskyi/view/routes/app_route.dart';

/// Util method for storing routes of all pages of the app.
Map<String, WidgetBuilder> get routes {
  return <String, WidgetBuilder>{
    AppRoute.home.path: (_) => const HomePage(),
    AppRoute.game.path: (_) => const GamePage(),
    AppRoute.unityGame.path: (_) => const UnityGamePage(),
    AppRoute.support.path: (_) => const SupportPage(),
  };
}
