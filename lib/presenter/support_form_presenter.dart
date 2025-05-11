import 'package:flutter/material.dart';
import 'package:resend/resend.dart';
import 'package:turskyi/model/models/support_form_data.dart';
import 'package:turskyi/res/constants.dart' as constants;

class SupportFormPresenter extends ChangeNotifier {
  final Resend _resend = Resend.instance;
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

  void updateFormData(String field, String value) {
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
    final String customerEmail = _formData.email;
    try {
      await _resend.sendEmail(
        from: 'Do Not Reply ${constants.appName} '
            '<no-reply@${constants.resendEmailDomain}>',
        to: <String>[constants.supportEmail],
        subject: 'New Message Received from ${constants.appName}',
        text: 'New support message received:\n\n Email: $customerEmail\n\n'
            'Name: ${_formData.name}\n\n Message: ${_formData.message}.',
      );

      await _resend.sendEmail(
        from: 'Do Not Reply ${constants.appName} '
            '<no-reply@${constants.resendEmailDomain}>',
        to: <String>[customerEmail],
        subject: 'Thank You! Your Support Message Has Been Sent to '
            '${constants.appName}',
        text: 'Thank you for reaching out to us! Your support message has been '
            'received and will be reviewed promptly. We appreciate your '
            'feedback and will get back to you soon.\n\nBest regards,\n'
            'The ${constants.appName} Team.',
      );

      _isSuccess = true;
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
