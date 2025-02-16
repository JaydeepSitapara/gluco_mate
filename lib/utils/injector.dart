import 'package:get_it/get_it.dart';
import 'package:gluco_mate/providers/sugar_data_provider.dart';
import 'package:gluco_mate/utils/database/local_db_provider.dart';

final sl = GetIt.instance;

void setupInjector() {
  sl.registerLazySingleton<SugarDataProvider>(() => SugarDataProvider());
  sl.registerLazySingleton<LocalDbProvider>(() => LocalDbProvider());
}
