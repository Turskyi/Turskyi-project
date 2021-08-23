import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/presentation/views/home/home_view.dart';
import 'package:url_launcher/url_launcher.dart';

/// [HomeModel] class is business logic of the [HomePage], storing all the
/// methods and variables
class HomeModel with ChangeNotifier {
  /// constructor for [HomeModel] class
  HomeModel(this._view, {required TickerProvider tickerProvider}) {
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: tickerProvider,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  final bool _isLoading = false;

  /// [isLoading] variable is storing a current state of the progress bar
  bool get isLoading => _isLoading;

  late AnimationController _animationController;

  /// [animationController] variable is storing an animation [Duration]
  /// and [TickerProvider] for one of the text views
  AnimationController get animationController => _animationController;
  late CurvedAnimation _curvedAnimation;

  /// [curvedAnimation] is a variable which storing [_animationController]
  /// and type of [Curves]
  CurvedAnimation get curvedAnimation => _curvedAnimation;
  final HomeView _view;

  /// [onHyperlinkTapped] accepts "link", checks if this link can be launched
  /// and opens the page in new browser tab
  Future<void> onHyperlinkTapped(String link) async {
    await canLaunch(link)
        ? await launch(link)
        : _view.displayMessage("${translate("home.cannot_launch")} $link");
  }
}
