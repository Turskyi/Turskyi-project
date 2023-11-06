import 'dart:html';
import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:turskyi/main/res/configs/configs.dart';
import 'package:turskyi/main/res/values/dimens.dart';
import 'package:turskyi/main/res/values/strings.dart';
import 'package:turskyi/model/links.dart';

/// [UnityGamePage] class represents a view of a game page
class UnityGamePage extends StatelessWidget {
  const UnityGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _registerHtmlView(context);
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

  void _registerHtmlView(BuildContext context) {
    platformViewRegistry.registerViewFactory(
      Configs.of(context).configs.htmlGameName,
      (_) => IFrameElement()
        ..src = Links.unityTwoDAddress
        ..style.border = Strings.noBorder
        ..style.height = Strings.oneHundredPercent
        ..style.width = Strings.oneHundredPercent,
    );
  }
}
