import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected;

  const DatePickerWidget({
    Key? key,
    this.initialDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
   DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            //accentColor: Colors.blueAccent,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      widget.onDateSelected(selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = selectedDate != null
        ? DateFormat('dd-MMM-yy').format(selectedDate!)
        : 'Select Date';

    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.dm),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 4),
              blurRadius: 8.dm,
            ),
          ],
        ),
        child: Padding(
          padding:  EdgeInsets.all(8.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black38,
                ),
              ),
              const  Icon(Icons.calendar_today, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
