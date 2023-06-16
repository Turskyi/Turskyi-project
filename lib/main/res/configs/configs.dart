import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:turskyi/main/res/configs/base/base_colors.dart';
import 'package:turskyi/main/res/configs/base/base_configs.dart';
import 'package:turskyi/main/res/configs/builds/main/main_colors.dart';
import 'package:turskyi/main/res/configs/builds/main/main_configs.dart';
import 'package:turskyi/view/app.dart';

/// [Configs] is an object data class which contains configuration of the app
class Configs extends InheritedWidget {
  /// constructor for specifying values required for data class [Configs]
  const Configs({
    Key? key,
    required this.colors,
    required this.configs,
    required this.child,
  }) : super(key: key, child: child);

  /// [colors] is a value containing colors of the app
  final BaseColors colors;

  /// [configs] is a value containing project specific values
  final BaseConfigs configs;

  @override
  final Widget child;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  /// [of] method is used to access project specific values
  static Configs of(BuildContext context) {
    final Configs? appConfigs = context.dependOnInheritedWidgetOfExactType(
      aspect: Configs,
    );
    if (appConfigs != null) {
      return appConfigs;
    } else {
      final MainConfigs configs = MainConfigs();
      return Configs(
        configs: configs,
        colors: MainColors(),
        child: const App(),
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget>('child', child));
  }
}
