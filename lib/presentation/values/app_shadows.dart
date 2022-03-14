import 'package:flutter/material.dart';

class AppShadows {
  /// [topRightTextShadow] [Shadow] variable for "shadows" parameter
  /// of [TextStyle], to give a shadow to a [Text]
  static const Shadow topRightTextShadow = Shadow(
    // topRight
    offset: Offset(1.0, 1.0), blurRadius: 4.0,
  );

  /// [bottomLeftTextShadow] [Shadow] variable for "shadows" parameter
  /// of [TextStyle], to give a shadow to a [Text]
  static const Shadow bottomLeftTextShadow = Shadow(
    // bottomLeft
    offset: Offset(-1.0, -1.0), blurRadius: 4.0,
  );
}
