enum AppRoute {
  /// When navigating to the "/" route, build the [HomePage] widget.
  home,

  /// When navigating to the "/game" route, build the [GamePage] widget.
  game,

  /// When navigating to the "/unity_game" route, build the [UnityGamePage] widget.
  unityGame,
  support,
  enHome,
  ukHome;

  String get path {
    const String home = '/';

    const String game = '${home}game';
    const String unityGame = '${home}unity_game';
    const String support = '${home}support';
    const String enHome = '${home}en';
    const String ukHome = '${home}uk';

    switch (this) {
      case AppRoute.home:
        return home;
      case AppRoute.game:
        return game;
      case AppRoute.unityGame:
        return unityGame;
      case AppRoute.support:
        return support;
      case AppRoute.enHome:
        return enHome;
      case AppRoute.ukHome:
        return ukHome;
    }
  }
}
