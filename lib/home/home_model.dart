import 'package:flutter/material.dart';
import 'package:turskyi/home/home_view.dart';

class HomeModel with ChangeNotifier {
  HomeView _view; // ignore: unused_field
  bool _isLoading = false;

  TextEditingController phoneEditingController = TextEditingController();

  bool get isLoading => _isLoading;

  HomeModel(this._view);
}
