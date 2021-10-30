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
    _flutterExperience = _setExperience(firstTime: _flutterFirstCommit);
    _androidExperience = _setExperience(firstTime: _androidFirstCommit);
  }

  final HomeView _view;

  final bool _isLoading = false;

  /// [isLoading] variable is storing a current state of the progress bar
  bool get isLoading => _isLoading;

  final DateTime _flutterFirstCommit = DateTime(2020, 09, 11);
  final DateTime _androidFirstCommit = DateTime(2019, 10);

  late AnimationController _animationController;

  /// [animationController] variable is storing an animation [Duration]
  /// and [TickerProvider] for one of the text views
  AnimationController get animationController => _animationController;
  late CurvedAnimation _curvedAnimation;

  /// [curvedAnimation] is a variable which storing [_animationController]
  /// and type of [Curves]
  CurvedAnimation get curvedAnimation => _curvedAnimation;

  String _flutterExperience = '';

  /// time passed since first commercial code was written
  String get flutterExperience => _flutterExperience;

  String _androidExperience = '';

  /// time passed since first commercial code was written
  String get androidExperience => _androidExperience;

  /// [onHyperlinkTapped] accepts "link", checks if this link can be launched
  /// and opens the page in new browser tab
  Future<void> onHyperlinkTapped(String link) async {
    await canLaunch(link)
        ? await launch(link)
        : _view.displayMessage("${translate("home.cannot_launch")} $link");
  }

  String _setExperience({required DateTime firstTime}) {
    final DateTime today = DateTime.now();

    //the first commit of commercial project
    final int totalDays = today.difference(firstTime).inDays;
    const int daysPerYear = 365;
    const int daysPerMonth = 30;
    /* "~/" is an integer division,
     22~/7 can be said as Integer division of 22 by 7,
      If either operand is a double
       then the result of the truncating division a ~/ b
        is equivalent to (a / b).truncate().toInt().*/
    // count the years, discarding the remainder of the days
    final int years = totalDays ~/ daysPerYear;
    final int daysWithoutYears = totalDays - years * daysPerYear;
    // count the months, discarding the remainder of the days
    final int months = daysWithoutYears ~/ daysPerMonth;
    // count the days, discarding the remainder of the years and months
    final int days = daysWithoutYears - months * daysPerMonth;

    final StringBuffer experienceStringBuffer = StringBuffer();
    if (years > 0) {
      experienceStringBuffer.write('$years year${years == 1 ? '' : 's'} ');
    }
    if (months > 0) {
      experienceStringBuffer.write('$months month${months == 1 ? '' : 's'} ');
    }
    if (days > 0) {
      experienceStringBuffer.write('$days day${days == 1 ? '' : 's'}');
    }
    return experienceStringBuffer.toString();
  }
}
