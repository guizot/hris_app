import 'package:get_it/get_it.dart';
import 'package:hantera/data/repositories/hive_repo_impl.dart';
import 'package:hantera/domain/repositories/hive_repo.dart';
import 'package:hantera/presentation/core/service/theme_service.dart';



import 'data/datasource/local/hive_data_source.dart';
import 'data/datasource/shared/shared_preferences_data_source.dart';




final sl = GetIt.I;

Future<void> init() async {

  /// SERVICES
  sl.registerLazySingleton(
    () => ThemeService(
      sharedPreferenceDataSource: sl(),
    ),
  );

  /// PRESENTATION LAYER





  /// DOMAIN LAYER





  /// DATA LAYER
  sl.registerLazySingleton<HiveRepo>(
    () => HiveRepoImpl(
      hiveDataSource: sl()
    ),
  );

  /// MAIN INJECTOR & EXTERNAL LIBRARY
  sl.registerLazySingleton(() => HiveDataSource());
  sl.registerLazySingleton(() => SharedPreferenceDataSource());

}