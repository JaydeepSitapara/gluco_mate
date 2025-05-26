import 'package:flutter/material.dart';
import 'package:gluco_mate/providers/patient_data_provider.dart';
import 'package:gluco_mate/screens/sugerdata/add_suger_data_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<PatientDataProvider>(create: (_) => PatientDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gluco-Mate',
      theme: ThemeData(
        // fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: AddSugerDataScreen(),
    );
  }
}
