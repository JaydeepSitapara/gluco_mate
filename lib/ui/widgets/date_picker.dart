import 'package:flutter/material.dart';
import 'package:gluco_mate/providers/sugar_data_provider.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:gluco_mate/utils/injector.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePickerWidget extends StatelessWidget {
  DatePickerWidget({
    super.key,
  });

  final sugarDataProvider = sl<SugarDataProvider>();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: sugarDataProvider.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            //accentColor: Colors.blueAccent,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      sugarDataProvider.updateDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = sugarDataProvider.selectedDate != null
        ? DateFormat('dd MMM yy').format(sugarDataProvider.selectedDate!)
        : 'Select Date';

    return GestureDetector(
      onTap: () => _selectDate(context),
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
              formattedDate,
              style: montserratStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
              ),
            ),
            const Icon(Icons.calendar_today, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
