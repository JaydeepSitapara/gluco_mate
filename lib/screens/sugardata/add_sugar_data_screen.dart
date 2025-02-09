import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gluco_mate/providers/patient_data_provider.dart';
import 'package:gluco_mate/screens/sugardata/sugar_data_list_screen.dart';
import 'package:gluco_mate/utils/injector.dart';
import 'package:gluco_mate/utils/style.dart';
import 'package:gluco_mate/utils/widgets/common_text_form_field.dart';
import 'package:gluco_mate/utils/widgets/condition_selection_drop_down.dart';
import 'package:gluco_mate/utils/widgets/custom_save_button.dart';
import 'package:gluco_mate/utils/widgets/date_picker.dart';
import 'package:gluco_mate/utils/widgets/time_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSugarDataScreen extends StatefulWidget {
  AddSugarDataScreen({super.key});

  @override
  State<AddSugarDataScreen> createState() => _AddSugarDataScreenState();
}

class _AddSugarDataScreenState extends State<AddSugarDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SugarDataProvider>(
      builder: (context, sugarDataProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0,
            leading: IconButton(
              icon: Icon(Icons.close, size: 26.h, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'New Record',
              style: montserratStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            elevation: 1,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(child: Divider(color: Colors.black26)),
                            SizedBox(width: 12.w),
                            Text(
                              'Condition',
                              style: montserratStyle(
                                fontSize: 16.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            const Expanded(child: Divider(color: Colors.black26)),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        CustomDropDown(),
                        SizedBox(height: 10.h),
                        CommonTextFormField(
                          controller: sugarDataProvider.sugarLevelController,
                          labelText: 'Sugar Concentration',
                          hintText: 'mg/dL',
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10.h),
                        CommonTextFormField(
                          controller: sugarDataProvider.notesLevelController,
                          maxLines: 4,
                          labelText: 'Notes',
                          hintText: 'Enter notes',
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DatePickerWidget(
                              onDateSelected: (value) {
                                sugarDataProvider.updateDate(value);
                                log('Selected Date : ${value.toString()} ');
                              },
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: TimePickerWidget(
                              onTimeSelected: (value) {
                                sugarDataProvider.updateTime(value);
                                log('Selected Time : ${value.toString()} ');
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      SaveButton(
                        onPressed: () async {
                          final res = await sugarDataProvider.addSugarData();

                          if (res > 0) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SugarDataListScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
