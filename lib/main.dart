import 'package:flutter/material.dart';
import 'package:turskyi/home.dart';

const _title = 'Developer Turskyi';

void main() {
  runApp(PersonalWebsiteApp());
}

class PersonalWebsiteApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF424443, {
          50: Color(0xFF424443),
          100: Color(0xFF424443),
          200: Color(0xFF424443),
          300: Color(0xFF424443),
          400: Color(0xFF424443),
          500: Color(0xFF424443),
          600: Color(0xFF424443),
          700: Color(0xFF424443),
          800: Color(0xFF424443),
          900: Color(0xFF424443),
        }),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: _title),
    );
  }
}