import 'package:flutter/material.dart';
import 'package:turskyi/res/values/dimens.dart';

class HyperlinkWidget extends StatelessWidget {
  const HyperlinkWidget({
    required this.title,
    required this.onTap,
    super.key,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
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
