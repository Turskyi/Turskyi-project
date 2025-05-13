import 'package:flutter/material.dart';
import 'package:turskyi/model/links.dart';
import 'package:turskyi/res/configs/configs.dart';
import 'package:turskyi/res/values/dimens.dart';
import 'package:turskyi/view/pages/game/web_platform_view.dart'
    if (dart.library.io) 'package:turskyi/view/pages/game/stub_platform_view.dart';

/// [UnityTwoDGamePage] class represents a view of a game page
class UnityTwoDGamePage extends StatelessWidget {
  const UnityTwoDGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    setupWebView(
      Configs.of(context).configs.htmlGameName,
      Links.unityTwoDAddress,
    );
    return Scaffold(
      backgroundColor: Configs.of(context).colors.background,
      appBar: AppBar(
        elevation: Dimens.noElevation,
        backgroundColor: Colors.transparent,
        toolbarHeight: Dimens.toolbarHeight,
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: HtmlElementView(
          viewType: Configs.of(context).configs.htmlGameName,
        ),
      ),
    );
  }
}
