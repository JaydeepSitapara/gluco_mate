import 'package:flutter/material.dart';
import 'package:gluco_mate/main.dart';
import 'package:gluco_mate/models/suger_data_model.dart';
import 'package:gluco_mate/providers/sugar_data_provider.dart';
import 'package:gluco_mate/ui/sugardata/sugar_data_list_screen.dart';
import 'package:gluco_mate/ui/theme/colors.dart';
import 'package:gluco_mate/config/injector.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:gluco_mate/ui/widgets/common_text_form_field.dart';
import 'package:gluco_mate/ui/widgets/condition_selection_drop_down.dart';
import 'package:gluco_mate/ui/widgets/custom_save_button.dart';
import 'package:gluco_mate/ui/widgets/date_picker.dart';
import 'package:gluco_mate/ui/widgets/time_picker.dart';
import 'package:gluco_mate/utils/services/shared_preference_service.dart';
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

    print('Selected Unit :${sl<SugarDataProvider>().selectedUnit}');

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
            backgroundColor: whiteColor,
            titleSpacing: 0,
            leading: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 28.h,
                ),
                onPressed: () => {
                      navigatorKey.currentState?.pop(context),
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
                              navigatorKey.currentState?.push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SugarDataListScreen(),
                                ),
                              );
                            }
                          },
                          child: Icon(
                            Icons.delete_forever_outlined,
                            size: 24.h,
                          )),
                    )
                  : const SizedBox(),
            ],
            title: Text(
              widget.isEditSugarData ?? false ? 'Update Record' : 'New Record',
              style: appBarTextStyle,
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
                      spacing: 1.h,
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
                                fontSize: 12.sp,
                                color: Colors.black38,
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
                          controller:
                          sugarDataProvider.sugarLevelController,
                          labelText: 'Sugar Concentration',
                          hintText: sugarDataProvider.selectedUnit  == 'Unit.mgdl' ? 'mg/dL' : 'mmolL',
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
                              navigatorKey.currentState?.push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SugarDataListScreen(),
                                ),
                              );
                            }
                          } else {
                            final res = await sugarDataProvider.addSugarData();

                            if (res > 0) {
                              navigatorKey.currentState?.push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SugarDataListScreen(),
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
