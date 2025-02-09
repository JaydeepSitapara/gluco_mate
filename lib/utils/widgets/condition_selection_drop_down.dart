import 'package:flutter/material.dart';
import 'package:gluco_mate/providers/patient_data_provider.dart';
import 'package:gluco_mate/utils/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomDropDown extends StatefulWidget {
  @override
  State<CustomDropDown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SugarDataProvider>(
        builder: (context, sugarDataProvider, child) {
      return Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.dm),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                // Lighter shadow color
                blurRadius: 12.dm,
                // Increased blur radius for more elevation
                offset: const Offset(0, 6), // Shadow spread
              ),
            ],
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
            dropdownColor: Colors.white,
            style: montserratStyle(fontSize: 14.sp, color: Colors.black),
            selectedItemBuilder: (BuildContext context) {
              return sugarDataProvider.conditionList
                  .map<Widget>((DropdownMenuItem<String> item) {
                return Center(
                  child: Text(
                    item.value ?? '',
                    style:
                        montserratStyle(fontSize: 18.sp, color: Colors.black45),
                  ),
                );
              }).toList();
            },
            // Adjust dropdown size// Set a maximum height for the dropdown
            alignment: Alignment.center,
            // Center align the dropdown items
            // You can add custom padding for the dropdown items
            padding: EdgeInsets.symmetric(vertical: 6.h),
          ),
        ),
      );
    });
  }
}
