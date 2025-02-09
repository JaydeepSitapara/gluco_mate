import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gluco_mate/utils/style.dart';

class TimePickerWidget extends StatefulWidget {
  final TimeOfDay? initialTime;
  final Function(TimeOfDay) onTimeSelected;

  const TimePickerWidget({
    Key? key,
    this.initialTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime ?? TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
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
      setState(() {
        selectedTime = pickedTime;
      });
      widget.onTimeSelected(selectedTime!);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format the time to display AM/PM
    String formattedTime = selectedTime != null
        ? selectedTime!.format(context)  // This will show AM/PM format
        : 'Select Time';

    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
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
