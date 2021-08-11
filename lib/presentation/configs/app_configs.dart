import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:turskyi/presentation/configs/base/base_colors.dart';
import 'package:turskyi/presentation/configs/base/base_configs.dart';
import 'package:turskyi/presentation/configs/builds/main/main_colors.dart';
import 'package:turskyi/presentation/configs/builds/main/main_configs.dart';
import 'package:turskyi/setup.dart';

/// [AppConfigs] is an object data class which contains configuration of the app
class AppConfigs extends InheritedWidget {
  /// constructor for specifying values required for data class [AppConfigs]
  const AppConfigs({
    required this.colors,
    required this.configs,
    required this.child,
  }) : super(child: child);

  /// [colors] is a value containing colors of the app
  final BaseColors colors;

  /// [configs] is a value containing project specific values
  final BaseConfigs configs;

  @override
  final Widget child;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  /// [of] method is used to access project specific values
  static AppConfigs of(BuildContext context) {
    final AppConfigs? appConfigs = context.dependOnInheritedWidgetOfExactType(
      aspect: AppConfigs,
    );
    if (appConfigs != null) {
      return appConfigs;
    } else {
      final MainConfigs configs = MainConfigs();
      return AppConfigs(
        configs: configs,
        colors: MainColors(),
        child: setup(configs),
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget>('child', child));
    properties.add(DiagnosticsProperty<Widget>('child', child));
  }
}
