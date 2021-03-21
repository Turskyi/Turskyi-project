import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:turskyi/presentation/home/home_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeModel with ChangeNotifier {
  final HomeView _view;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  late AnimationController _animationController;

  AnimationController get animationController => _animationController;
  late CurvedAnimation _curvedAnimation;

  CurvedAnimation get curvedAnimation => _curvedAnimation;

  HomeModel(this._view, {required TickerProvider tickerProvider}) {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: tickerProvider,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  Future<void> onHyperlinkTapped(String link) async {
    await canLaunch(link)
        ? await launch(link)
        :  _view.displayMessage("${translate("home.cannot_launch")} $link");
  }
}
