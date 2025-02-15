import 'package:flutter/material.dart';
import 'package:gluco_mate/providers/patient_data_provider.dart';
import 'package:gluco_mate/ui/theme/colors.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SugarDataProvider>(
        builder: (context, sugarDataProvider, child) {
      return Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.w,
            ),
          ),
          child: DropdownButton<String>(
            value: sugarDataProvider.selectedCondition,
            items: sugarDataProvider.conditionList,
            onChanged: (value) {
              sugarDataProvider.updateSelectedCondition(value);
            },
            isExpanded: true,
            // Ensures dropdown takes full width
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
              size: 28.h,
            ),
            dropdownColor: whiteColor,
            borderRadius: BorderRadius.circular(10.r),
            style: montserratStyle(fontSize: 14.sp, color: blackColor),
            selectedItemBuilder: (BuildContext context) {
              return sugarDataProvider.conditionList
                  .map<Widget>((DropdownMenuItem<String> item) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.value ?? '',
                    style:
                        montserratStyle(fontSize: 15.sp, color: blackColor),
                  ),
                );
              }).toList();
            },
            // Adjust dropdown size// Set a maximum height for the dropdown
            alignment: Alignment.center,
            menuMaxHeight: 350.h,
            underline: const SizedBox(),
            // Center align the dropdown items
            // You can add custom padding for the dropdown items
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 14.w),
          ),
        ),
      );
    });
  }
}
