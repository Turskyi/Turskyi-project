import 'package:flutter/material.dart';
import 'package:turskyi/res/configs/base/base_colors.dart';

/// [MainColors] is a class containing list of project specific color values
class MainColors implements BaseColors {
  @override
  MaterialColor primarySwatch = const MaterialColor(
    0xFF424443, // The primary color (500)
    <int, Color>{
      50: Color(0xFFF5F5F5), // Very light grey
      100: Color(0xFFE0E0E0), // Light grey
      200: Color(0xFFBDBDBD), // Light-medium grey
      300: Color(0xFF9E9E9E), // Medium grey
      400: Color(0xFF757575), // Medium-dark grey
      500: Color(0xFF424443), // Your original color
      600: Color(0xFF404241), // Slightly darker
      700: Color(0xFF303231), // Darker
      800: Color(0xFF212322), // Very dark
      900: Color(0xFF000000), // Black
    },
  );

  @override
  Color colorFacebook = const Color(0xFF405A94);

  @override
  Color colorFacebookWithOpacity = const Color(0xFF405A94).withValues(
    alpha: 0.5,
  );

  @override
  Color background = const Color(0xFFA6A7A7);

  @override
  Color colorWishlistWithOpacity = const Color(0xFFC93806).withValues(
    alpha: 0.3,
  );

  @override
  Color colorWishlist = const Color(0xFFC93806);
}
