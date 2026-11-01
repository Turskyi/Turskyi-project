import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:turskyi/model/data_sources/remote/support_api_client.dart';
import 'package:turskyi/model/models/support_form_data.dart';
import 'package:turskyi/model/models/support_response.dart';

class SupportFormPresenter extends ChangeNotifier {
  SupportFormPresenter({final SupportApiClient? apiClient})
    : _apiClient = apiClient ?? SupportApiClient(Dio());

  final SupportApiClient _apiClient;
  SupportFormData _formData = const SupportFormData(
    name: '',
    email: '',
    message: '',
  );
  bool _isLoading = false;
  bool _isSuccess = false;
  String _errorMessage = '';

  SupportFormData get formData => _formData;

  bool get isLoading => _isLoading;

  bool get isSuccess => _isSuccess;

  String get errorMessage => _errorMessage;

  void updateFormData(final String field, final String value) {
    _formData = _formData.copyWith(
      name: field == 'name' ? value : null,
      email: field == 'email' ? value : null,
      message: field == 'message' ? value : null,
    );
    notifyListeners();
  }

  void resetForm() {
    _formData = const SupportFormData(name: '', email: '', message: '');
    _isLoading = false;
    _isSuccess = false;
    _errorMessage = '';
    notifyListeners();
  }

  Future<void> sendSupportEmail() async {
    _isLoading = true;
    _isSuccess = false;
    _errorMessage = '';
    notifyListeners();

    try {
      final SupportResponse response = await _apiClient.sendSupportEmail(
        _formData,
      );
      if (response.success) {
        _isSuccess = true;
      } else {
        _errorMessage = response.message.isNotEmpty
            ? response.message
            : 'Failed to send message. Please try again.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
