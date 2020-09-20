import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/home/home_view.dart';

class HomeModel with ChangeNotifier {
  HomeView _view;
  bool _isLoading = false;

  TextEditingController phoneEditingController = TextEditingController();

  bool get isLoading => _isLoading;

  HomeModel(this._view);

  void login() async {
    _isLoading = true;
    notifyListeners();

    try {

    } catch (e) {
      print(e);
      _view.displayMessage(translate("home.error"));
    }
    _isLoading = false;
    notifyListeners();
  }
}
