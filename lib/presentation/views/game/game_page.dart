import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:turskyi/presentation/configs/app_configs.dart';

/// [GamePage] class represents a presenter of a landing page
class GamePage extends StatelessWidget{
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory(
        AppConfigs.of(context).configs.htmlName, (int viewId) {
      return IFrameElement()
        ..src = 'https://unitythreedgame.web.app'
        ..style.border = 'none';
    });
    return Scaffold(
      backgroundColor: AppConfigs.of(context).colors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 72,
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: HtmlElementView(
          viewType: AppConfigs.of(context).configs.htmlName,
        ),
      ),
    );
  }
}
