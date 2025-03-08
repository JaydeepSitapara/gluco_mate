import 'package:flutter/material.dart';
import 'package:gluco_mate/main.dart';
import 'package:gluco_mate/providers/sugar_data_provider.dart';
import 'package:gluco_mate/ui/splash/widgets/custom_list_tile.dart';
import 'package:gluco_mate/ui/sugardata/sugar_data_list_screen.dart';
import 'package:gluco_mate/ui/theme/colors.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:gluco_mate/ui/widgets/custom_save_button.dart';
import 'package:gluco_mate/utils/services/shared_preference_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnitSelectionScreen extends StatefulWidget {
  const UnitSelectionScreen({super.key});

  @override
  _UnitSelectionScreenState createState() => _UnitSelectionScreenState();
}

class _UnitSelectionScreenState extends State<UnitSelectionScreen> {
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'Select Unit',
          style: appBarTextStyle,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<SugarDataProvider>(
        builder: (context, sugarDataProvider, child) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomListTile(
                  title: 'mg/dL',
                  trailing: sugarDataProvider.selectedUnit == '${Unit.mgdl}'
                      ? const Icon(Icons.check)
                      : const SizedBox(),
                  tileColor:
                      sugarDataProvider.selectedUnit == '${Unit.mgdl}'
                          ? Colors.blue.shade50
                          : whiteColor,

                  onTap: () {
                    sugarDataProvider.selectedUnit = '${Unit.mgdl}';
                  },
                ),
                CustomListTile(
                  title: 'mmol/L',
                  trailing: sugarDataProvider.selectedUnit == '${Unit.mmolL}'
                      ? const Icon(Icons.check)
                      : const SizedBox(),
                  tileColor:
                  sugarDataProvider.selectedUnit == '${Unit.mmolL}'
                      ? Colors.blue.shade50
                      : whiteColor,

                  onTap: () {
                    sugarDataProvider.selectedUnit = '${Unit.mmolL}';
                  },
                ),
                const Spacer(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  child: SaveButton(
                      onPressed: () async {
                        await _sharedPreferenceService.saveString(
                            SharedPreferenceKeys.unit,
                            sugarDataProvider.selectedUnit ?? '');
                        await _sharedPreferenceService.saveBool(
                            SharedPreferenceKeys.isUnitSelected, true);
                        navigatorKey.currentState?.push(
                          MaterialPageRoute(
                            builder: (context) => const SugarDataListScreen(),
                          ),
                        );
                      },
                      buttonText: 'Continue'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
