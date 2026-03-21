import 'package:flutter_translate/flutter_translate.dart';
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/model/use_cases/initialize_app_language_use_case.dart';
import 'package:turskyi/res/configs/builds/main/main_configs.dart';

class Dependencies {
  const Dependencies({
    required this.localDataSource,
    required this.mainConfigs,
    required this.initializeAppLanguageUseCase,
    required this.localizationDelegate,
  });

  final LocalDataSource localDataSource;
  final MainConfigs mainConfigs;
  final InitializeAppLanguageUseCase initializeAppLanguageUseCase;
  final LocalizationDelegate localizationDelegate;
}
