enum AppRoute {
  /// When navigating to the "/" route, build the [HomePage] widget.
  home,

  /// When navigating to the "/game" route, build the [GamePage] widget.
  game,
}

extension RouteExtension on AppRoute {
  String get path {
    const String home = '/';

    const String game = '${home}game';

    switch (this) {
      case AppRoute.home:
        return home;
      case AppRoute.game:
        return game;
    }
  }
}
