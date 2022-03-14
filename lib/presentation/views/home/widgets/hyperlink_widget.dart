import 'package:flutter/material.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';

class HyperlinkWidget extends StatelessWidget {
  const HyperlinkWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
                fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
