import 'package:flutter/material.dart';
import 'package:turskyi/presentation/configs/builds/main/main_colors.dart';

/// [BaseColors] abstract class containing color variables which will be
/// initialized in [MainColors] during launch depending on build configuration.
abstract class BaseColors {
  ///  the different shades of a color a material app will use.
  late MaterialColor primarySwatch;

  /// color of the shadow behind facebook button
  late Color colorFacebookWithOpacity;

  /// backgroundColor for "facebook" button
  late Color colorFacebook;
}
