import 'package:flutter/material.dart';

class HomeModel with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  HomeModel();
}
