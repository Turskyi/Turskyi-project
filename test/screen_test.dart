import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turskyi/view/util/screen.dart';

void main() {
  testWidgets('isWide returns true for wide screens', (
    WidgetTester tester,
  ) async {
    // Define a wide screen size
    const Size wideScreenSize = Size(1200, 800);

    // Build a widget with the specified screen size
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: wideScreenSize),
        child: Builder(
          builder: (BuildContext context) {
            // Verify that isWide returns true for wide screens
            expect(isLarge(context), isTrue);
            return Container();
          },
        ),
      ),
    );
  });

  testWidgets('isWide returns false for narrow screens', (
    WidgetTester tester,
  ) async {
    // Define a narrow screen size
    const Size narrowScreenSize = Size(599, 800);

    // Build a widget with the specified screen size
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: narrowScreenSize),
        child: Builder(
          builder: (BuildContext context) {
            // Verify that isWide returns false for narrow screens
            expect(isLarge(context), isFalse);
            return Container();
          },
        ),
      ),
    );
  });

  testWidgets('isWide returns true for screens just above the threshold', (
    WidgetTester tester,
  ) async {
    // Define a screen size just above the threshold
    const Size justAboveThresholdSize = Size(600, 800);

    // Build a widget with the specified screen size
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: justAboveThresholdSize),
        child: Builder(
          builder: (BuildContext context) {
            // Verify that isWide returns true for screens just above the
            // threshold.
            expect(isLarge(context), isTrue);
            return Container();
          },
        ),
      ),
    );
  });
}
