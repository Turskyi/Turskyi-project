import 'package:flutter/material.dart';
import 'package:turskyi/presenter/home_presenter.dart';
import 'package:turskyi/view/pages/home/home_page.dart';

/// [HomeView] is an interface for accessing [HomePage] from [HomePresenter]
abstract interface class HomeView {
  /// [displayMessage] accepts [String] text and showing [SnackBar]
  void displayMessage(String message);
}
