import 'package:get_it/get_it.dart';
import 'package:gluco_mate/providers/sugar_data_provider.dart';
import 'package:gluco_mate/utils/database/local_db_provider.dart';
import 'package:gluco_mate/utils/services/shared_preference_service.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<SugarDataProvider>(() => SugarDataProvider());
  sl.registerLazySingleton<LocalDbProvider>(() => LocalDbProvider());
  sl.registerLazySingleton<SharedPreferenceService>(() => SharedPreferenceService());
}
