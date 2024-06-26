import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class FullNameText extends StatelessWidget {
  const FullNameText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      translate('home.name'),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: Theme.of(
          context,
        ).textTheme.headlineMedium?.fontSize,
      ),
    );
  }
}
