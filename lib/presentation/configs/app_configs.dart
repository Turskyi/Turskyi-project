import 'package:flutter/widgets.dart';
import 'package:turskyi/presentation/configs/base/base_colors.dart';
import 'package:turskyi/presentation/configs/base/base_configs.dart';

class AppConfigs extends InheritedWidget {
  final BaseColors colors;
  final BaseConfigs configs;
  final Widget child;

  AppConfigs(
      {required this.colors, required this.configs, required this.child})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static AppConfigs of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: AppConfigs)!;
  }
}
