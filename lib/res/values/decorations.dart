import 'package:flutter/material.dart';
import 'package:turskyi/main/res/values/dimens.dart';

/// Decoration attribute which used in [Container] around [Text] to set dark
/// background.
BoxDecoration textDecoration = BoxDecoration(
  color: Colors.black,
  border: Border.all(color: Colors.white),
  boxShadow: const <BoxShadow>[
    BoxShadow(
      // topRight
      offset: Offset(Dimens.offset1, Dimens.offset1),
      color: Colors.white,
      blurRadius: Dimens.shadowRadius,
    ),
    BoxShadow(
      // bottomLeft
      offset: Offset(Dimens.offsetMinus1, Dimens.offsetMinus1),
      color: Colors.white,
      blurRadius: Dimens.shadowRadius,
    ),
  ],
  borderRadius: BorderRadius.circular(Dimens.borderRadius),
);
