import 'package:flutter/material.dart';
import 'package:gluco_mate/providers/sugar_data_provider.dart';
import 'package:gluco_mate/ui/splash/splash_screen.dart';
import 'package:gluco_mate/utils/database/db_helper.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:gluco_mate/utils/database/local_db_provider.dart';
import 'package:gluco_mate/utils/injector.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDB();
  setupInjector();
  runApp(
    Phoenix(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => sl<SugarDataProvider>()),
          ChangeNotifierProvider(create: (_) => sl<LocalDbProvider>()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Gluco-Mate',
        theme: ThemeData(
          // fontFamily: 'Montserrat',
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
