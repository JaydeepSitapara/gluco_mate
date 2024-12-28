import 'package:flutter/material.dart';
import 'package:gluco_mate/providers/patient_data_provider.dart';
import 'package:gluco_mate/screens/sugerdata/add_suger_data_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {

  //runApp(const MyApp());
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PatientDataProvider()),
        ],
        child: const MyApp(),
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
        title: 'Gluco-Mate',
        theme: ThemeData(
          // fontFamily: 'Montserrat',
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: AddSugerDataScreen(),
      ),
    );
  }
}
