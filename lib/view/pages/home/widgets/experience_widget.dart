import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/res/values/decorations.dart' as decorations;
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/view/util/screen.dart' as screen;

class ExperienceWidget extends StatelessWidget {
  const ExperienceWidget({
    required this.flutterExperience,
    required this.androidExperience,
    required this.totalExperience,
    super.key,
  });

  final String flutterExperience;
  final String androidExperience;
  final String totalExperience;

  @override
  Widget build(BuildContext context) {
    final bool isLarge = screen.isLarge(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle? textStyle = isLarge
        ? textTheme.headlineMedium
        : textTheme.titleLarge;
    final double height = MediaQuery.of(context).size.height;

    return Row(
      children: <Widget>[
        Expanded(
          child: SelectionArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (height > 340)
                  Container(
                    padding: const EdgeInsets.only(
                      left: Dimens.indent12,
                      right: Dimens.indent12,
                      bottom: Dimens.indent4,
                    ),
                    margin: const EdgeInsets.only(
                      top: Dimens.indent40,
                      bottom: Dimens.indent4,
                    ),
                    decoration: decorations.textDecoration,
                    child: Text(translate('home.experience'), style: textStyle),
                  ),
                if (height > 380)
                  Container(
                    padding: const EdgeInsets.only(
                      left: Dimens.indent12,
                      right: Dimens.indent12,
                      bottom: Dimens.indent4,
                    ),
                    decoration: decorations.textDecoration,
                    margin: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${translate('home.flutter')} $flutterExperience',
                      style: textStyle,
                    ),
                  ),
                if (height > 414)
                  Container(
                    padding: const EdgeInsets.only(
                      left: Dimens.indent12,
                      right: Dimens.indent12,
                      bottom: Dimens.indent4,
                    ),
                    decoration: decorations.textDecoration,
                    margin: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${translate('home.android')} $androidExperience',
                      style: textStyle,
                    ),
                  ),
                if (height > 444)
                  Container(
                    padding: const EdgeInsets.only(
                      left: Dimens.indent12,
                      right: Dimens.indent12,
                      bottom: Dimens.indent4,
                    ),
                    decoration: decorations.textDecoration,
                    child: Text(
                      '${translate('home.total')} $totalExperience',
                      style: textStyle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
