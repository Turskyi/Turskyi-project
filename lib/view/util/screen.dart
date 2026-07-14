import 'package:flutter/material.dart';
import 'package:turskyi/res/values/dimens.dart';

bool isLarge(final BuildContext context) {
  final double shortestSide = _getShortestSide(context);
  final bool isLarge = shortestSide > Dimens.maxPortraitWidth;
  return isLarge;
}

/// The equivalent of the "smallestWidth" qualifier on Android SDK.
double _getShortestSide(final BuildContext context) {
  final double shortestSide = MediaQuery.of(context).size.shortestSide;
  return shortestSide;
}
