import 'package:flutter_test/flutter_test.dart';
import 'package:turskyi/main/main.dart' as app;
import 'package:turskyi/main/res/configs/builds/main/main_colors.dart';
import 'package:turskyi/main/res/configs/builds/main/main_configs.dart';
import 'package:turskyi/main/res/configs/configs.dart';
import 'package:turskyi/view/app.dart';

void main() {
  testWidgets('Main app initialization test', (WidgetTester tester) async {
    // Run the app
    app.main();

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify that the Configs widget is built with the correct configurations
    final Configs configsWidget = tester.widget(find.byType(Configs));
    expect(configsWidget.configs, isA<MainConfigs>());
    expect(configsWidget.colors, isA<MainColors>());

    // Verify that the App widget is present
    expect(find.byType(App), findsOneWidget);
  });
}
