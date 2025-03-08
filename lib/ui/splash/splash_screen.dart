import 'package:flutter/material.dart';
import 'package:gluco_mate/config/injector.dart';
import 'package:gluco_mate/main.dart';
import 'package:gluco_mate/providers/sugar_data_provider.dart';
import 'package:gluco_mate/ui/splash/unit_selection_screen.dart';
import 'package:gluco_mate/ui/sugardata/sugar_data_list_screen.dart';
import 'package:gluco_mate/ui/theme/colors.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gluco_mate/utils/services/shared_preference_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();

  @override
  initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      bool isUnitSelected = await _sharedPreferenceService
          .getBool(SharedPreferenceKeys.isUnitSelected);

      if (!isUnitSelected) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => const UnitSelectionScreen(),
          ),
        );
      } else {
        final unit = await sl<SharedPreferenceService>()
            .getString(SharedPreferenceKeys.unit);

        sl<SugarDataProvider>().selectedUnit = unit;

        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => const SugarDataListScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Gluco Mate',
              style: montserratStyle(
                fontSize: 51.sp,
                color: blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              'Your health, our priority!',
              style: montserratStyle(
                fontSize: 16.sp,
                color: blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
