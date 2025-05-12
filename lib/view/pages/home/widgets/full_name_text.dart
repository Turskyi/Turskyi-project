import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/view/util/screen.dart' as screen;

class FullNameText extends StatelessWidget {
  const FullNameText({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLarge = screen.isLarge(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      translate('home.name'),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: isLarge
            ? textTheme.headlineMedium?.fontSize
            : textTheme.headlineSmall?.fontSize,
      ),
    );
  }
}
