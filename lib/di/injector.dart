import 'package:dio/dio.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turskyi/di/dependencies.dart';
import 'package:turskyi/localization/flutter_translate_app_locale_port.dart';
import 'package:turskyi/localization/localization_delegate_getter.dart'
    as locale;
import 'package:turskyi/model/data_sources/local/database/ranking_database.dart';
import 'package:turskyi/model/data_sources/local/local_data_source.dart';
import 'package:turskyi/model/data_sources/remote/support_api_client.dart';
import 'package:turskyi/model/repositories/ranking_repository.dart';
import 'package:turskyi/model/use_cases/initialize_app_language_use_case.dart';
import 'package:turskyi/res/configs/builds/main/main_configs.dart';

Future<Dependencies> injectDependencies() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final LocalDataSource localDataSource = LocalDataSource(preferences);
  final MainConfigs mainConfigs = MainConfigs();
  final LocalizationDelegate localizationDelegate = await locale
      .getLocalizationDelegate(localDataSource);
  final FlutterTranslateAppLocalePort appLocalePort =
      FlutterTranslateAppLocalePort(localizationDelegate: localizationDelegate);
  final InitializeAppLanguageUseCase initializeAppLanguageUseCase =
      InitializeAppLanguageUseCase(
        localDataSource: localDataSource,
        appLocalePort: appLocalePort,
      );

  final RankingDatabase rankingDatabase = RankingDatabase();
  final SupportApiClient supportApiClient = SupportApiClient(Dio());
  final RankingRepository rankingRepository = RankingRepository(
    database: rankingDatabase,
    apiClient: supportApiClient,
  );

  return Dependencies(
    localDataSource: localDataSource,
    mainConfigs: mainConfigs,
    initializeAppLanguageUseCase: initializeAppLanguageUseCase,
    localizationDelegate: localizationDelegate,
    rankingDatabase: rankingDatabase,
    rankingRepository: rankingRepository,
  );
}
