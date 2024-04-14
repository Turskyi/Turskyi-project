import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:turskyi/main/res/values/dimens.dart';
import 'package:turskyi/presenter/home_presenter.dart';

/// Build title of the occupation
class OccupationWidget extends StatelessWidget {
  const OccupationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.indent4),
      child: Consumer<HomePresenter>(
        builder:
            (BuildContext context, HomePresenter model, Widget? homeTitle) {
          return FadeTransition(
            opacity: model.curvedAnimation,
            child: MouseRegion(
              onEnter: model.onTitleHover,
              onExit: model.onTitleHover,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AnimatedContainer(
                    width: model.suffixWidth,
                    duration: model.expandDuration,
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      translate('home.suffix_title'),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.fontSize,
                      ),
                    ),
                  ),
                  homeTitle ?? const SizedBox(),
                ],
              ),
            ),
          );
        },
        child: Text(
          translate('home.title'),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
            fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
          ),
        ),
      ),
    );
  }
}
