import 'package:flutter/material.dart';
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/view/util/screen.dart' as screen;

class HyperlinkWidget extends StatelessWidget {
  const HyperlinkWidget({required this.title, required this.onTap, super.key});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isLarge = screen.isLarge(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double? fontSize = isLarge
        ? textTheme.titleMedium?.fontSize
        : textTheme.titleSmall?.fontSize;
    return Container(
      padding: EdgeInsets.only(top: isLarge ? 10.0 : Dimens.indent8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.indent12,
              vertical: isLarge ? Dimens.indent12 : Dimens.indent8,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
                fontSize: fontSize,
                decorationColor: Colors.white70,
                decorationThickness: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
