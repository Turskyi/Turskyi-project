import 'package:turskyi/main/res/configs/builds/main/main_configs.dart';

///[BaseConfigs] is an abstract class containing list of project dynamic values,
/// which will be initialised in [MainConfigs] class.
abstract class BaseConfigs {
  /// [String] path to location of the images in project tree structure
  late String imageAssents;

  /// [String] name of the html page
  late String htmlName;
}
