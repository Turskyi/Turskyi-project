import 'package:flutter/material.dart';
import 'package:turskyi/presentation/home/home_model.dart';
import 'package:turskyi/presentation/home/home_page.dart';

/// [HomeView] is an interface for accessing [HomePage] from [HomeModel]
abstract class HomeView {
  /// [displayMessage] accepts [String] text and showing [SnackBar]
  void displayMessage(String message);
}
