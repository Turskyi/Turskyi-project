import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:turskyi/main/res/configs/configs.dart';
import 'package:turskyi/main/res/values/dimens.dart';
import 'package:turskyi/main/res/values/strings.dart';

/// [GamePage] class represents a view of a game page
class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

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
    // ignore: avoid_dynamic_calls
    ui.platformViewRegistry.registerViewFactory(
      Configs.of(context).configs.htmlName,
      (_) => IFrameElement()
        ..src = Strings.unityThreeDAddress
        ..style.border = Strings.noBorder
        ..style.height = Strings.oneHundredPercent
        ..style.width = Strings.oneHundredPercent,
    );
  }
}