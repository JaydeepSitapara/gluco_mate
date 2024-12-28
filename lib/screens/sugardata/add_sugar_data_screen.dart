import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gluco_mate/providers/patient_data_provider.dart';
import 'package:gluco_mate/utils/widgets/common_text_form_field.dart';
import 'package:gluco_mate/utils/widgets/condition_selection_drop_down.dart';
import 'package:gluco_mate/utils/widgets/custom_save_button.dart';
import 'package:gluco_mate/utils/widgets/date_picker.dart';
import 'package:gluco_mate/utils/widgets/time_picker.dart';

import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSugerDataScreen extends StatefulWidget {
  AddSugerDataScreen({super.key});

  @override
  State<AddSugerDataScreen> createState() => _AddSugerDataScreenState();
}

class _AddSugerDataScreenState extends State<AddSugerDataScreen> {
  final sugarLevelController = TextEditingController();
  final notesLevelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        leading: Icon(
          Icons.close,
          size: 26.h,
        ),
        title: Text(
          'New Record',
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
      body: Consumer<PatientDataProvider>(
        builder: (context, patientDataProvider, child) {
          return Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Column(
              spacing: 5.0.h,
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                  ],
                ),

                CustomDropdown(),
                SizedBox(height: 10.h),
                CommonTextFormField(
                  controller: sugarLevelController,
                  labelText: 'Super Concentration',
                  hintText: 'mmol/L',
                ),
                SizedBox(height: 5.h),
                CommonTextFormField(
                  controller: notesLevelController,
                  maxLines: 4,
                  labelText: 'Notes',
                  hintText: 'notes',
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
                    SizedBox(width: 10.w,),
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
                SizedBox(height: 1.h),
                SaveButton(
                  onPressed: () {
                    log('Condition : ${patientDataProvider.selectedCondition}');
                    log('Sugar Level : ${sugarLevelController.text.toString()}');
                    log('Notes : ${notesLevelController.text.toString()}');
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
