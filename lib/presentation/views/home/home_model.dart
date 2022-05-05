import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/core/constants.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';
import 'package:turskyi/presentation/values/app_strings.dart';
import 'package:turskyi/presentation/views/home/home_view.dart';
import 'package:url_launcher/url_launcher.dart';

/// [HomeModel] class is business logic of the [HomePage], storing all the
/// methods and variables
class HomeModel with ChangeNotifier {
  /// constructor for [HomeModel] class
  HomeModel(this._view, {required TickerProvider tickerProvider}) {
    _fadeAnimationController = AnimationController(
      duration: const Duration(seconds: AppDimens.fiveSeconds),
      vsync: tickerProvider,
    );
    _rotationAnimationController = AnimationController(
      duration: expandDuration,
      vsync: tickerProvider,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeIn,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: _rotationAnimationController,
        curve: Curves.easeOut,
      ),
    );
    _fadeAnimationController.forward();
    _flutterExperience = _setExperience(
      firstTime: _flutterFirstCommit,
      gapDuration:
          _flutterLastCommit.difference(DateTime(2022, DateTime.may, 9)),
    );
    _androidExperience = _setExperience(
      firstTime: _androidFirstCommit,
      lastTime: _androidLastCommit,
    );
  }

  final HomeView _view;

  late final Animation<double> _rotationAnimation;

  /// controls degree of the rotation
  Animation<double> get rotationAnimation => _rotationAnimation;

  late AnimationController _fadeAnimationController;
  late AnimationController _rotationAnimationController;
  late CurvedAnimation _curvedAnimation;

  /// [curvedAnimation] is a variable which storing [_fadeAnimationController]
  /// and type of [Curves]
  CurvedAnimation get curvedAnimation => _curvedAnimation;

  final bool _isLoading = false;

  /// [isLoading] variable is storing a current state of the progress bar
  bool get isLoading => _isLoading;

  final Duration _expandDuration = const Duration(milliseconds: 400);

  /// controls duration of the expanded animation
  Duration get expandDuration => _expandDuration;

  /// https://github.com/MyRoadStudio/text-to-speech-flutter/commits/master
  final DateTime _flutterFirstCommit = flutterFirstCommit;
  final DateTime _flutterLastCommit = flutterLastCommit;

  /// https://gitlab.com/IntSoftware/redbook/commits/master
  final DateTime _androidFirstCommit = androidFirstCommit;

  /// https://github.com/MyRoadStudio/happy-life-android/commits/master
  final DateTime _androidLastCommit = androidLastCommit;

  String _flutterExperience = '';

  /// time passed since first commercial code was written
  String get flutterExperience => _flutterExperience;

  String _androidExperience = '';

  /// time passed since first commercial code was written
  String get androidExperience => _androidExperience;

  String _daysToBirthday = '';

  /// contains value of days left until birthday
  String get daysToBirthday => _daysToBirthday;

  double _wishlistWidth = AppDimens.widthColorButton;

  /// controls the width of the "wishlist" button
  double get wishlistWidth => _wishlistWidth;

  double _suffixWidth = 0;

  /// controls the width of the "suffix" of the title
  double get suffixWidth => _suffixWidth;

  /// [onLaunchLink] accepts "link", checks if this link can be launched
  /// and opens the page in new browser tab
  Future<void> onLaunchLink(String link) async {
    await canLaunch(link)
        ? await launch(link)
        : _view.displayMessage("${translate("home.cannot_launch")} $link");
  }

  String _setExperience({
    required DateTime firstTime,
    DateTime? lastTime,
    Duration? gapDuration,
  }) {
    final int gapDays = gapDuration?.inDays ?? 0;
    final int totalDays =
        (lastTime ?? DateTime.now()).difference(firstTime).inDays - gapDays;
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

  /// rotates "wishlist" logo and expands text
  void onWishListButtonAnimate(PointerEvent event) {
    if (daysToBirthday.isEmpty) {
      final DateTime today = DateTime.now();
      final DateTime birthday = DateTime(today.year, 1, 13);
      final int days = _daysBetween(
        today,
        today.isAfter(birthday) ? DateTime(today.year + 1, 1, 13) : birthday,
      );
      _daysToBirthday = '$days days to birthday';
      _wishlistWidth = AppDimens.wishlistButtonWidth;
      _rotationAnimationController.forward();
    } else {
      _daysToBirthday = '';
      _wishlistWidth = AppDimens.widthColorButton;
      _rotationAnimationController.reverse();
    }
    notifyListeners();
  }

  /// rotates "wishlist" logo and expands text
  void onTitleHover(PointerEvent event) {
    if (_suffixWidth == 0) {
      _suffixWidth = 172;
    } else {
      _suffixWidth = 0;
    }
    notifyListeners();
  }

  int _daysBetween(DateTime from, DateTime to) {
    return (to.difference(from).inHours / 24).round();
  }

  Future<void> onPhoneButtonPressed() async {
    /* Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
     Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
     such as spaces in the input, which would cause `launch` to fail on some
     platforms.
  */
    final Uri launchUri = Uri(
      scheme: AppStrings.phoneScheme,
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _rotationAnimationController.dispose();
    super.dispose();
  }
}
