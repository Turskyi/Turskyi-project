import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:turskyi/presentation/configs/base/base_colors.dart';

/// [MainColors] is a class containing list of project specific color values
class MainColors implements BaseColors {
  @override
  MaterialColor primarySwatch = const MaterialColor(0xFF424443, <int, Color>{
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
  Color colorFacebook = const Color(0xFF405A94);

  @override
  Color colorFacebookWithOpacity = const Color(0xFF405A94).withOpacity(0.6);

  @override
  Color background = const Color(0xFFA6A7A7);
}
