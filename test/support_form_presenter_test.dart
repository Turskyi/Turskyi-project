import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:turskyi/model/data_sources/remote/support_api_client.dart';
import 'package:turskyi/model/models/support_response.dart';
import 'package:turskyi/presenter/support_form_presenter.dart';

import 'support_form_presenter_test.mocks.dart';

@GenerateMocks(<Type>[SupportApiClient])
void main() {
  late MockSupportApiClient mockApiClient;
  late SupportFormPresenter presenter;

  setUp(() {
    mockApiClient = MockSupportApiClient();
    presenter = SupportFormPresenter(apiClient: mockApiClient);
  });

  test('updateFormData updates correct values', () {
    presenter.updateFormData('name', 'John Doe');
    presenter.updateFormData('email', 'john@example.com');
    presenter.updateFormData('message', 'Hello world');

    expect(presenter.formData.name, 'John Doe');
    expect(presenter.formData.email, 'john@example.com');
    expect(presenter.formData.message, 'Hello world');
  });

  test('resetForm resets form state', () {
    presenter.updateFormData('name', 'John Doe');
    presenter.resetForm();

    expect(presenter.formData.name, '');
    expect(presenter.formData.email, '');
    expect(presenter.formData.message, '');
    expect(presenter.isLoading, false);
    expect(presenter.isSuccess, false);
    expect(presenter.errorMessage, '');
  });

  test('sendSupportEmail succeeds when apiClient returns success', () async {
    presenter.updateFormData('name', 'John');
    presenter.updateFormData('email', 'john@example.com');
    presenter.updateFormData('message', 'Test');

    when(mockApiClient.sendSupportEmail(any)).thenAnswer(
      (final _) async => const SupportResponse(
        success: true,
        message: 'Email sent successfully',
      ),
    );

    await presenter.sendSupportEmail();

    expect(presenter.isSuccess, true);
    expect(presenter.isLoading, false);
    expect(presenter.errorMessage, '');
  });

  test('sendSupportEmail fails when apiClient returns success=false', () async {
    when(mockApiClient.sendSupportEmail(any)).thenAnswer(
      (final _) async =>
          const SupportResponse(success: false, message: 'Failed to send'),
    );

    await presenter.sendSupportEmail();

    expect(presenter.isSuccess, false);
    expect(presenter.errorMessage, 'Failed to send');
  });

  test('sendSupportEmail catches exception and sets errorMessage', () async {
    when(
      mockApiClient.sendSupportEmail(any),
    ).thenThrow(Exception('Network error'));

    await presenter.sendSupportEmail();

    expect(presenter.isSuccess, false);
    expect(presenter.errorMessage, contains('Exception: Network error'));
  });
}
