import 'package:flutter/material.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';

class Screen {
  static bool isWide(BuildContext context) {
    final double shortestSide = _getShortestSide(context);
    final bool isLarge = shortestSide > AppDimens.maxPortraitWidth;
    return isLarge;
  }

  /// The equivalent of the "smallestWidth" qualifier on Android SDK.
  static double _getShortestSide(BuildContext context) {
    final double shortestSide = MediaQuery.of(
      context,
    ).size.shortestSide;
    return shortestSide;
  }
}
