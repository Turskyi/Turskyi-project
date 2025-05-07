import 'package:flutter/material.dart';
import 'package:turskyi/res/values/dimens.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.padding = Dimens.indent32,
    this.backgroundColor,
    this.valueColor,
    this.strokeWidth = 6.0,
    this.size = 48.0,
  });

  final double padding;
  final Color? backgroundColor;
  final Color? valueColor;
  final double strokeWidth;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: CircularProgressIndicator(
            backgroundColor: backgroundColor ?? Colors.black38,
            color: valueColor ?? Colors.grey.shade100,
            valueColor: valueColor != null
                ? AlwaysStoppedAnimation<Color>(valueColor!)
                : null,
            strokeWidth: strokeWidth,
          ),
        ),
      ),
    );
  }
}
