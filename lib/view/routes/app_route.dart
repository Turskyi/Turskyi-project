enum AppRoute {
  /// When navigating to the "/" route, build the [HomePage] widget.
  home,

  /// When navigating to the "/game" route, build the [GamePage] widget.
  game,

  /// When navigating to the "/unity_game" route, build the [UnityGamePage] widget.
  unityGame,
  support,
}

extension RouteExtension on AppRoute {
  String get path {
    const String home = '/';

    const String game = '${home}game';
    const String unityGame = '${home}unity_game';
    const String support = '${home}support';

    switch (this) {
      case AppRoute.home:
        return home;
      case AppRoute.game:
        return game;
      case AppRoute.unityGame:
        return unityGame;
      case AppRoute.support:
        return support;
    }
  }
}
