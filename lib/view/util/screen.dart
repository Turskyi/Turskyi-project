import 'package:flutter/material.dart';
import 'package:turskyi/main/res/values/dimens.dart';

class Screen {
  static bool isWide(BuildContext context) {
    final double shortestSide = _getShortestSide(context);
    final bool isLarge = shortestSide > Dimens.maxPortraitWidth;
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
