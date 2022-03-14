import 'package:flutter/material.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';
import 'package:turskyi/presentation/values/app_shadows.dart';

/// Util class containing commonly used widget styles
class AppStyles {
  // START: [TextStyle]s
  /// custom H6 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline6 = TextStyle(
    fontSize: AppDimens.headline6,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    letterSpacing: AppDimens.letterSpacingH6,
    color: Colors.white,
    height: AppDimens.fontH6Height,
    shadows: <Shadow>[
      AppShadows.topRightTextShadow,
      AppShadows.bottomLeftTextShadow,
    ],
  );

  /// custom H5 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline5 = TextStyle(
    fontSize: AppDimens.headline5,
    fontStyle: FontStyle.normal,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    height: AppDimens.fontH5Height,
    shadows: <Shadow>[
      AppShadows.topRightTextShadow,
      AppShadows.bottomLeftTextShadow,
    ],
  );

  /// custom H4 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline4 = TextStyle(
    fontSize: AppDimens.headline4,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    letterSpacing: AppDimens.letterSpacingH4,
    color: Colors.white,
    height: AppDimens.fontH4Height,
    shadows: <Shadow>[
      AppShadows.topRightTextShadow,
      AppShadows.bottomLeftTextShadow,
    ],
  );

  /// custom H3 font style from https://material.io/design/typography/the-type-system.html#type-scale
  static const TextStyle headline3 = TextStyle(
    fontSize: AppDimens.headline3,
    fontStyle: FontStyle.normal,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    height: AppDimens.fontH3Height,
    shadows: <Shadow>[
      AppShadows.topRightTextShadow,
      AppShadows.bottomLeftTextShadow,
    ],
  );

// END: [TextStyle]s

}
