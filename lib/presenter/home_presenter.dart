import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/model/date_times.dart' as date_times;
import 'package:turskyi/model/models/project.dart';
import 'package:turskyi/presenter/time.dart';
import 'package:turskyi/res/constants.dart' as constants;
import 'package:turskyi/res/language.dart';
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/res/values/strings.dart' as strings;
import 'package:turskyi/view/pages/home/home_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// [HomePresenter] class is business logic of the [HomePage], storing all the
/// methods and variables.
class HomePresenter with ChangeNotifier {
  /// Constructor for [HomePresenter] class.
  HomePresenter({
    required HomeView view,
    required TickerProvider tickerProvider,
    required LocalDataSource localDataSource,
  }) {
    _view = view;
    _fadeAnimationController = AnimationController(
      duration: Duration(seconds: Time.fade.value),
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
      gapDuration: _flutterLastCommit.difference(
        DateTime(2022, DateTime.may, 9),
      ),
    );
    _androidExperience = _setExperience(
      firstTime: _androidFirstCommit,
      lastTime: _androidLastCommit,
    );
    _totalExperience = _setExperience(firstTime: _androidFirstCommit);
    _language = localDataSource.getSavedLanguage();
    _localDataSource = localDataSource;
  }

  late HomeView _view;
  late final Animation<double> _rotationAnimation;

  late AnimationController _fadeAnimationController;
  late AnimationController _rotationAnimationController;
  late CurvedAnimation _curvedAnimation;

  late Language _language;

  Language get language => _language;

  late LocalDataSource _localDataSource;

  /// Controls degree of the rotation.
  Animation<double> get rotationAnimation => _rotationAnimation;

  /// [curvedAnimation] is a variable which storing [_fadeAnimationController]
  /// and type of [Curves]
  CurvedAnimation get curvedAnimation => _curvedAnimation;

  bool _isLoading = false;

  /// [isLoading] variable is storing a current state of the progress bar.
  bool get isLoading => _isLoading;

  final Duration _expandDuration = const Duration(milliseconds: 400);

  /// Controls duration of the expanded animation.
  Duration get expandDuration => _expandDuration;

  /// https://github.com/MyRoadStudio/text-to-speech-flutter/commits/master.
  final DateTime _flutterFirstCommit = date_times.flutterFirstCommit;
  final DateTime _flutterLastCommit = date_times.flutterLastCommit;

  /// https://gitlab.com/IntSoftware/redbook/commits/master.
  final DateTime _androidFirstCommit = date_times.androidFirstCommit;

  /// https://github.com/MyRoadStudio/happy-life-android/commits/master.
  final DateTime _androidLastCommit = date_times.androidLastCommit;

  String _totalExperience = '';

  String get totalExperience => _totalExperience;

  String _flutterExperience = '';

  /// time passed since first commercial code was written
  String get flutterExperience => _flutterExperience;

  String _androidExperience = '';

  /// time passed since first commercial code was written
  String get androidExperience => _androidExperience;

  String _daysToBirthday = '';

  /// contains value of days left until birthday
  String get daysToBirthday => _daysToBirthday;

  double _wishlistWidth = Dimens.widthColorButton;

  /// controls the width of the "wishlist" button
  double get wishlistWidth => _wishlistWidth;

  double _suffixWidth = 0;

  /// controls the width of the "suffix" of the title
  double get suffixWidth => _suffixWidth;

  List<Project> get allProjects => _localDataSource.allProjects;

  /// [onLaunchLink] accepts "link", checks if this link can be launched
  /// and opens the page in new browser tab
  Future<void> onLaunchLink(String link) async {
    await canLaunchUrlString(link)
        ? await launchUrlString(link)
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
  void onWishListButtonAnimate([
    PointerEvent event = const PointerMoveEvent(),
  ]) {
    if (daysToBirthday.isEmpty) {
      final DateTime today = DateTime.now();
      final DateTime birthday = DateTime(today.year, 1, 13);
      final int days = _daysBetween(
        today,
        today.isAfter(birthday) ? DateTime(today.year + 1, 1, 13) : birthday,
      );
      _daysToBirthday = translate(
        'home.days_to_birthday',
        args: <String, Object?>{'days': days},
      );
      _wishlistWidth = _language.isEnglish ? Dimens.wishlistButtonWidth : 240;
      _rotationAnimationController.forward();
    } else {
      _daysToBirthday = '';
      _wishlistWidth = Dimens.widthColorButton;
      _rotationAnimationController.reverse();
    }
    notifyListeners();
  }

  /// rotates "wishlist" logo and expands text
  void onTitleHover(PointerEvent event) {
    if (_suffixWidth == 0) {
      _suffixWidth = _language.isEnglish ? 172 : 204;
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
      scheme: strings.phoneScheme,
      path: strings.phoneNumber,
    );
    await launchUrl(launchUri);
  }

  /// Attempts to open the project's primary website. If it's unreachable,
  /// tries a fallback.
  ///
  /// ### Why this is necessary:
  /// In some cases, project domains may become unavailable — e.g., if I forget
  /// to renew them.
  /// However, many projects also have a free-hosted fallback (like Firebase or
  /// Vercel) that can still work.
  ///
  /// ### What's going on:
  /// 1. Try to `HEAD` the primary URL to check if it's alive.
  ///    - If status is `200`, launch it directly.
  ///    - Otherwise, fall back to the backup URL.
  ///
  /// 2. Unfortunately, [Dio] cannot distinguish between:
  ///    - A truly expired/unavailable domain (e.g., DNS error)
  ///    - A **CORS-restricted** domain (like Cloudflare-protected apps)
  ///
  /// 3. Chrome can differentiate these in DevTools (CORS error vs.
  /// `ERR_NAME_NOT_RESOLVED`), but [Dio] just throws
  /// [DioExceptionType.connectionError] for both.
  ///
  /// 4. Workaround for the CORS case:
  ///    - Retry the request using a **CORS proxy**
  ///    (`https://cors-anywhere.com/`)
  ///    - If this proxy request succeeds, we know the domain is alive and CORS
  ///    was the issue.
  ///    - In that case, we try launching the original URL anyway.
  ///
  /// 5. If both attempts fail — we show the fallback site.
  ///    - In some edge cases (e.g. Clerk domain lock), fallback is just an
  ///    explanation/snackbar.
  Future<void> checkAndLaunchProjectWebsite(Project project) async {
    _isLoading = true;
    notifyListeners();
    final String primaryUrl = project.primaryWebsiteUrl;
    final String fallbackUrl = project.fallbackWebsiteUrl;
    final Dio dio = Dio();

    try {
      final Response<void> response = await dio.head(primaryUrl);

      if (response.statusCode == HttpStatus.ok) {
        await _launchUrl(primaryUrl);
      } else {
        if (kDebugMode) {
          debugPrint('Unexpected status: ${response.statusCode}');
        }
        await _launchFallbackUrl(fallbackUrl);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('Dio error while checking $primaryUrl:');
        debugPrint('Type: ${e.type}');
        debugPrint('Message: ${e.message}');
        debugPrint('Error: ${e.error}');
        debugPrint('Response: ${e.response}');
      }

      if (e.type == DioExceptionType.connectionError) {
        try {
          // TODO: migrate hosting website from github pages to a platform that
          // allows custom API routes, somewhere we can set up a serverless
          // backend, to build a proper CORS-aware backend, until then use this
          // workaround.
          final String proxyPrimaryUrl =
              '${constants.kCorsProxyUrl}$primaryUrl';
          final Response<void> response = await dio.head(proxyPrimaryUrl);

          if (response.statusCode == HttpStatus.ok) {
            await _launchUrl(primaryUrl);
          } else {
            if (kDebugMode) {
              debugPrint(
                'DioException (cors-anywhere): Unexpected status while '
                'checking proxy $primaryUrl -> $proxyPrimaryUrl: '
                '${response.statusCode}',
              );
            }
            await _launchFallbackUrl(fallbackUrl);
          }
        } on DioException catch (eCors) {
          if (kDebugMode) {
            debugPrint(
              'Dio error while checking proxy $primaryUrl: \n'
              'eCors.type: ${eCors.type}, \n'
              'eCors.message: ${eCors.message}, \n'
              'eCors.error: ${eCors.error}, \n'
              'eCors.response: ${eCors.response}.',
            );
          }

          if (fallbackUrl.isNotEmpty) {
            await _handleFallbackUrl(fallbackUrl);
          } else if (eCors.type == DioExceptionType.connectionError) {
            try {
              await _launchUrl(primaryUrl);
            } catch (eLaunch) {
              if (kDebugMode) {
                debugPrint(
                  '‼️ Last attempt to launch primary URL "$primaryUrl" '
                  'FAILED.\n'
                  '   Previous attempts (direct HEAD, proxy HEAD) resulted in '
                  'DioExceptionType.connectionError.\n'
                  '   Current _launchUrl error type: ${eLaunch.runtimeType}\n'
                  '   Current _launchUrl error: $eLaunch',
                );
              }
              _view.displayMessage(
                'Unfortunately, this project is not accessible at the moment. '
                'You can contact the developer via '
                'https://turskyi.com/#/support to find out more.',
              );
              return;
            }
          }
        }
      } else {
        if (kDebugMode) {
          debugPrint(
            'DioException (non-connection error) encountered for $primaryUrl: '
            '$e',
          );
        }
        await _handleFallbackUrl(fallbackUrl);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(
          'Generic catch block: An unexpected error of type ${e.runtimeType} '
          'occurred: $e',
        );
      }

      await _handleFallbackUrl(fallbackUrl);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _handleFallbackUrl(String fallbackUrl) async {
    _view.displayMessage(
      "Couldn't reach the main website. Opening fallback URL.",
    );
    await _launchFallbackUrl(fallbackUrl);
  }

  Future<void> _launchFallbackUrl(String fallbackUrl) async {
    if (fallbackUrl.trim().isEmpty) {
      _view.displayMessage(
        'Unfortunately, this project is not accessible at the moment. '
        'You can contact the developer via https://turskyi.com/#/support to '
        'find out more.',
      );
      return;
    }

    await _launchUrl(fallbackUrl);
  }

  /// Launches a given URL.
  /// Displays an error message if the URL cannot be launched.
  Future<void> _launchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      // Handle potential errors during URL launching (less common than HTTP
      // errors, but good to be safe)
      debugPrint('Error launching URL $url: $e');
      _view.displayMessage("Couldn't open the link: $url");
    }
  }

  Future<void> changeLanguage(Language language) async {
    if (language != _language) {
      final bool isSaved = await _localDataSource.saveLanguageIsoCode(
        language.isoLanguageCode,
      );
      if (isSaved && !_isLoading) {
        _language = language;
        notifyListeners();
      } else {
        //TODO: handle this case.
      }
    }
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _rotationAnimationController.dispose();
    super.dispose();
  }
}
