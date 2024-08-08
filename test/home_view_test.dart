import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:turskyi/view/pages/home/home_view.dart';

import 'home_view_test.mocks.dart';

@GenerateMocks(<Type>[HomeView])
void main() {
  late MockHomeView mockHomeView;

  setUp(() {
    mockHomeView = MockHomeView();
  });

  group('HomeView', () {
    test('displayMessage should show a SnackBar with the given message', () {
      const String message = 'Test message';
      mockHomeView.displayMessage(message);
      verify(mockHomeView.displayMessage(message)).called(1);
    });
  });
}
