import 'package:flutter/material.dart';
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/res/values/shadows.dart';

/// Util class containing commonly used widget styles
class Styles {
  // START: [TextStyle]s
  /// custom H6 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline6 = TextStyle(
    fontSize: Dimens.headline6,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    letterSpacing: Dimens.letterSpacingH6,
    color: Colors.white,
    height: Dimens.fontH6Height,
    shadows: <Shadow>[
      Shadows.topRightTextShadow,
      Shadows.bottomLeftTextShadow,
    ],
  );

  /// custom H5 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline5 = TextStyle(
    fontSize: Dimens.headline5,
    fontStyle: FontStyle.normal,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    height: Dimens.fontH5Height,
    shadows: <Shadow>[
      Shadows.topRightTextShadow,
      Shadows.bottomLeftTextShadow,
    ],
  );

  /// custom H4 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline4 = TextStyle(
    fontSize: Dimens.headline4,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    letterSpacing: Dimens.letterSpacingH4,
    color: Colors.white,
    height: Dimens.fontH4Height,
    shadows: <Shadow>[
      Shadows.topRightTextShadow,
      Shadows.bottomLeftTextShadow,
    ],
  );

  /// custom H3 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline3 = TextStyle(
    fontSize: Dimens.headline3,
    fontStyle: FontStyle.normal,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    height: Dimens.fontH3Height,
    shadows: <Shadow>[
      Shadows.topRightTextShadow,
      Shadows.bottomLeftTextShadow,
    ],
  );

// END: [TextStyle]s
}
