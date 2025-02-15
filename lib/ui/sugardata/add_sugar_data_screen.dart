import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gluco_mate/models/suger_data_model.dart';
import 'package:gluco_mate/providers/patient_data_provider.dart';
import 'package:gluco_mate/ui/sugardata/sugar_data_list_screen.dart';
import 'package:gluco_mate/utils/injector.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:gluco_mate/ui/widgets/common_text_form_field.dart';
import 'package:gluco_mate/ui/widgets/condition_selection_drop_down.dart';
import 'package:gluco_mate/ui/widgets/custom_save_button.dart';
import 'package:gluco_mate/ui/widgets/date_picker.dart';
import 'package:gluco_mate/ui/widgets/time_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSugarDataScreen extends StatefulWidget {
  AddSugarDataScreen({
    super.key,
    this.isEditSugarData,
    this.sugarData,
  });

  final bool? isEditSugarData;
  final SugarData? sugarData;

  @override
  State<AddSugarDataScreen> createState() => _AddSugarDataScreenState();
}

class _AddSugarDataScreenState extends State<AddSugarDataScreen> {
  final sugarDataProvider = sl<SugarDataProvider>();

  @override
  void initState() {
    super.initState();
    if (widget.isEditSugarData ?? false) {
      print('SugarData Id: ${widget.sugarData?.id}');

      sugarDataProvider
          .updateSugarValue(widget.sugarData?.sugarValue.toString() ?? '');

      sugarDataProvider.updateNotes(widget.sugarData?.notes ?? '');

      sugarDataProvider
          .updateSelectedCondition(widget.sugarData?.measured ?? '');

      //here passing the date to the provider
      //to update the date in the provider
      sugarDataProvider.updateDate(
          DateTime.tryParse(widget.sugarData?.date ?? '') ?? DateTime.now());
      sugarDataProvider.updateTime(TimeOfDay.fromDateTime(
          DateTime.tryParse(widget.sugarData?.time ?? '') ?? DateTime.now()));
    } else {}
  }

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
                onPressed: () => {
                      Navigator.pop(context),
                      sugarDataProvider.sugarLevelController.clear(),
                      sugarDataProvider.notesController.clear(),
                      sugarDataProvider.selectedCondition =
                          'Morning Before Breakfast',
                      sugarDataProvider.selectedDate = DateTime.now(),
                      sugarDataProvider.selectedTime = TimeOfDay.now(),
                    }),
            actions: [
              widget.isEditSugarData ?? false
                  ? Padding(
                      padding: EdgeInsets.only(right: 4.0.h),
                      child: InkWell(
                          onTap: () async {
                            final response = await sugarDataProvider
                                .deleteSugarData(widget.sugarData?.id ?? 0);

                            if (response > 0) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SugarDataListScreen(),
                                ),
                              );
                            }
                          },
                          child: const Icon(Icons.delete)),
                    )
                  : const SizedBox(),
            ],
            title: Text(
              widget.isEditSugarData ?? false ? 'Update' : 'New Record',
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
                            const Expanded(
                                child: Divider(color: Colors.black26)),
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
                            const Expanded(
                                child: Divider(color: Colors.black26)),
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
                          controller: sugarDataProvider.notesController,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DatePickerWidget(),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: TimePickerWidget(),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      SaveButton(
                        buttonText:
                            widget.isEditSugarData ?? false ? 'Update' : 'Save',
                        onPressed: () async {
                          if (widget.isEditSugarData ?? false) {
                            final res = await sugarDataProvider
                                .updateSugarData(widget.sugarData?.id ?? 0);

                            if (res > 0) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SugarDataListScreen(),
                                ),
                              );
                            }
                          } else {
                            final res = await sugarDataProvider.addSugarData();

                            if (res > 0) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SugarDataListScreen(),
                                ),
                              );
                            }
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
