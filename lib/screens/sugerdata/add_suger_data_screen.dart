import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gluco_mate/providers/patient_data_provider.dart';
import 'package:gluco_mate/widgets/common_text_form_field.dart';
import 'package:gluco_mate/widgets/condition_selection_drop_down.dart';
import 'package:gluco_mate/widgets/custom_save_button.dart';
import 'package:gluco_mate/widgets/date_picker.dart';
import 'package:gluco_mate/widgets/time_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSugerDataScreen extends StatefulWidget {
  AddSugerDataScreen({super.key});

  @override
  State<AddSugerDataScreen> createState() => _AddSugerDataScreenState();
}

class _AddSugerDataScreenState extends State<AddSugerDataScreen> {
  final sugerLevelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        leading: Icon(
          Icons.close,
          size: 30.h,
        ),
        title: Text(
          'New Record',
          style: TextStyle(fontSize: 22.sp),
        ),
      ),
      body: Consumer<PatientDataProvider>(
        builder: (context, patientDataProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 10.0.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Divider(),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      'Condition',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                CustomDropdown(),
                SizedBox(height: 30.h),
                CommonTextFormField(
                  controller: sugerLevelController,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: DatePickerWidget(
                        onDateSelected: (value) {
                          patientDataProvider.updateDate(value);
                          log('Selected Date : ${value.toString()} ');
                        },
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: TimePickerWidget(
                        onTimeSelected: (value) {
                          patientDataProvider.updateTime(value);
                          log('Selected Time : ${value.toString()} ');
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.w),
                SaveButton(
                  onPressed: () {
                    log('Condition : ${patientDataProvider.selectedCondition}');
                    log('Suger Level : ${sugerLevelController.text.toString()}');
                    log('Date Time : ${patientDataProvider.selectedDate} -- ${patientDataProvider.selectedTime} ');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
