import 'dart:html';
import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:turskyi/main/res/configs/configs.dart';
import 'package:turskyi/main/res/values/dimens.dart';
import 'package:turskyi/main/res/values/strings.dart' as strings;
import 'package:turskyi/model/links.dart';

/// [GamePage] class represents a view of a game page
class GamePage extends StatelessWidget {
  const GamePage({super.key});

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
          viewType: Configs.of(context).configs.htmlName,
        ),
      ),
    );
  }

  void _registerHtmlView(BuildContext context) {
    platformViewRegistry.registerViewFactory(
      Configs.of(context).configs.htmlName,
      (_) => IFrameElement()
        ..src = Links.unityThreeDAddress
        ..style.border = strings.noBorder
        ..style.height = strings.oneHundredPercent
        ..style.width = strings.oneHundredPercent,
    );
  }
}
