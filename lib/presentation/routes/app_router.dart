import 'package:flutter/material.dart';
import 'package:turskyi/presentation/routes/app_route.dart';
import 'package:turskyi/presentation/views/game/game_page.dart';
import 'package:turskyi/presentation/views/home/home_page.dart';

/// Util class for storing routes of all pages of the app
class AppRouter {
  static Map<String, WidgetBuilder> get routes {
    return <String, WidgetBuilder>{
      AppRoute.home.path: (BuildContext context) => const HomePage(),
      AppRoute.game.path: (BuildContext context) => const GamePage(),
    };
  }
}
