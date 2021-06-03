import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:turskyi/presentation/configs/base/base_colors.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';

class MainColors implements BaseColors {
  @override
  MaterialColor primarySwatch = MaterialColor(0xFF424443, {
    50: Color(0xFF424443),
    100: Color(0xFF424443),
    200: Color(0xFF424443),
    300: Color(0xFF424443),
    400: Color(0xFF424443),
    500: Color(0xFF424443),
    600: Color(0xFF424443),
    700: Color(0xFF424443),
    800: Color(0xFF424443),
    900: Color(0xFF424443),
  });

  @override
  Color colorFacebook = Color(0xFF405A94);

  @override
  Color colorFacebookWithOpacity = Color(0xFF405A94).withOpacity(
    AppDimens.opacityShadow,
  );
}
