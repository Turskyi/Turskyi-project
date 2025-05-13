// ignore_for_file: deprecated_member_use
import 'dart:html';
import 'dart:ui_web';

import 'package:turskyi/res/values/strings.dart' as strings;

void setupWebView(String viewType, String src) {
  platformViewRegistry.registerViewFactory(
    viewType,
    (_) => IFrameElement()
      ..src = src
      ..style.border = strings.noBorder
      ..style.height = strings.oneHundredPercent
      ..style.width = strings.oneHundredPercent,
  );
}
