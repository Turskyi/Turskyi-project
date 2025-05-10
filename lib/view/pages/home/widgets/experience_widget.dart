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
    return Row(
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                child: Text(
                  translate('home.experience'),
                  style: isLarge
                      ? Theme.of(context).textTheme.headlineMedium
                      : Theme.of(context).textTheme.titleLarge,
                ),
              ),
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
                  style: isLarge
                      ? Theme.of(context).textTheme.headlineMedium
                      : Theme.of(context).textTheme.titleLarge,
                ),
              ),
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
                  style: isLarge
                      ? Theme.of(context).textTheme.headlineMedium
                      : Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: Dimens.indent12,
                  right: Dimens.indent12,
                  bottom: Dimens.indent4,
                ),
                decoration: decorations.textDecoration,
                child: Text(
                  '${translate('home.total')} $totalExperience',
                  style: isLarge
                      ? Theme.of(context).textTheme.headlineMedium
                      : Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
