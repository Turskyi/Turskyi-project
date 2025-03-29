import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:turskyi/res/configs/base/base_colors.dart';
import 'package:turskyi/res/configs/base/base_configs.dart';
import 'package:turskyi/res/configs/builds/main/main_colors.dart';
import 'package:turskyi/res/configs/builds/main/main_configs.dart';
import 'package:turskyi/view/app.dart';

/// [Configs] is an object data class which contains configuration of the app
class Configs extends InheritedWidget {
  /// constructor for specifying values required for data class [Configs]
  const Configs({
    required this.colors,
    required this.configs,
    required super.child,
    super.key,
  });

  /// [colors] is a value containing colors of the app
  final BaseColors colors;

  /// [configs] is a value containing project specific values
  final BaseConfigs configs;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  /// Retrieves the closest instance of this class that encloses the given
  /// context.
  ///
  /// This method is conventionally used in Flutter to provide a way to access
  /// the data stored in an [InheritedWidget]. Although the linter rule
  /// `prefer_constructors_over_static_methods` suggests using constructors
  /// over static methods, in the case of [InheritedWidget] patterns, the static
  /// [of] method is the recommended and established approach.
  ///
  /// The `of` method is designed to be called from child widgets to access the
  /// inherited widget's data. It uses
  /// [context.dependOnInheritedWidgetOfExactType] to find and return the
  /// nearest instance of [Configs] in the widget tree.
  ///
  /// This method is static because it does not operate on an instance of the
  /// [Configs] class, but rather on the [BuildContext] to locate an instance of
  /// the class higher up in the widget tree.
  ///
  /// Muting the `prefer_constructors_over_static_methods` linter rule is
  /// necessary here because:
  /// 1. The [of] method's purpose is to provide a statically accessible method
  ///    to retrieve the inherited widget instance.
  /// 2. This pattern is widely used and recognized in Flutter's architecture
  ///    for managing inherited data.
  /// 3. Following the linter rule would contradict the best practices and
  ///    conventions established in the Flutter framework.
  ///
  /// Throws a [FlutterError] if no [Configs] ancestor is found in the widget
  /// tree.
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
    properties.add(DiagnosticsProperty<BaseColors>('colors', colors));
    properties.add(DiagnosticsProperty<BaseConfigs>('configs', configs));
  }
}
