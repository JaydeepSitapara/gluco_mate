import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gluco_mate/providers/sugar_data_provider.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:gluco_mate/utils/injector.dart';

class TimePickerWidget extends StatelessWidget {
  TimePickerWidget({super.key});

  final sugarDataProvider = sl<SugarDataProvider>();

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: sugarDataProvider.selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      sugarDataProvider.updateTime(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format the time to display AM/PM
    String formattedTime = sugarDataProvider.selectedTime != null
        ? sugarDataProvider.selectedTime!
            .format(context) // This will show AM/PM format
        : 'Select Time';

    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.dm),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 4),
              blurRadius: 4.dm,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formattedTime,
              style: montserratStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
              ),
            ),
            const Icon(Icons.access_time, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
