import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';

/// Util class containing commonly used widget styles
class AppStyles {
  // START: [Text] styles
  /// custom H6 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline6 = TextStyle(
    fontSize: AppDimens.headline6,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.15,
    color: Colors.white,
    height: 1.3,
    shadows: <Shadow>[topRightTextShadow, bottomLeftTextShadow],
  );

  /// custom H5 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline5 = TextStyle(
    fontSize: AppDimens.headline5,
    fontStyle: FontStyle.normal,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    height: 3,
    shadows: <Shadow>[topRightTextShadow, bottomLeftTextShadow],
  );

  /// custom H4 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline4 = TextStyle(
    fontSize: AppDimens.headline4,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.25,
    color: Colors.white,
    height: 1.3,
    shadows: <Shadow>[topRightTextShadow, bottomLeftTextShadow],
  );

  /// custom H3 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline3 = TextStyle(
    fontSize: AppDimens.headline3,
    fontStyle: FontStyle.normal,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    height: 3,
    shadows: <Shadow>[topRightTextShadow, bottomLeftTextShadow],
  );

// END: [Text] styles

  // START: [BorderRadius] styles
  /// [radiusButton] variable contains specific circular [BorderRadius] value,
  /// for all buttons of the app
  static final BorderRadius radiusButton = BorderRadius.circular(20.0);

// END: [BorderRadius] styles

// START: [Shadow] styles
  /// [topRightTextShadow] [Shadow] variable for "shadows" parameter
  /// of [TextStyle], to give a shadow to a [Text]
  static const Shadow topRightTextShadow = Shadow(
    // topRight
    offset: Offset(1.0, 1.0),
    blurRadius: 4.0,
  );

  /// [bottomLeftTextShadow] [Shadow] variable for "shadows" parameter
  /// of [TextStyle], to give a shadow to a [Text]
  static const Shadow bottomLeftTextShadow = Shadow(
    // bottomLeft
    offset: Offset(-1.0, -1.0),
    blurRadius: 4.0,
  );

// END: [Shadow] styles

}
