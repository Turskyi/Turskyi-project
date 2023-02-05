import 'package:flutter/material.dart';
import 'package:turskyi/presentation/values/app_dimens.dart';

class AppDecorations {
  /// decoration attribute which used in [Container] around [Text] to
  /// set dark background
  static final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.black,
    border: Border.all(color: Colors.white),
    boxShadow: const <BoxShadow>[
      BoxShadow(
        // topRight
        offset: Offset(AppDimens.offset1, AppDimens.offset1),
        color: Colors.white,
        blurRadius: AppDimens.shadowRadius,
      ),
      BoxShadow(
        // bottomLeft
        offset: Offset(AppDimens.offsetMinus1, AppDimens.offsetMinus1),
        color: Colors.white,
        blurRadius: AppDimens.shadowRadius,
      )
    ],
    borderRadius: BorderRadius.circular(AppDimens.borderRadius),
  );
}
