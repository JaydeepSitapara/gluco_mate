import 'package:flutter/material.dart';
import 'package:gluco_mate/providers/patient_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomDropdown extends StatefulWidget {
  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    final patientDataProvider = Provider.of<PatientDataProvider>(context);

    return Center(
      child: Container(
        width: double.infinity,
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.dm),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),  // Lighter shadow color
              blurRadius: 12.dm,  // Increased blur radius for more elevation
              offset: const Offset(0, 6),  // Shadow spread
            ),
          ],
        ),
        child: DropdownButton<String>(
          value: patientDataProvider.selectedCondition,
          items: patientDataProvider.conditionList,
          onChanged: (value) {
            patientDataProvider.updateSelectedCondition(value);
          },
          isExpanded: true,  // Ensures dropdown takes full width
          icon:  Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
            size: 28.h,
          ),
          dropdownColor: Colors.white,
          style: TextStyle(fontSize: 14.sp, color: Colors.black),
          selectedItemBuilder: (BuildContext context) {
            return patientDataProvider.conditionList
                .map<Widget>((DropdownMenuItem<String> item) {
              return Center(
                child: Text(
                  item.value!,
                  style:  TextStyle(fontSize: 18.sp, color: Colors.black45),
                ),
              );
            }).toList();
          },
          // Adjust dropdown size// Set a maximum height for the dropdown
          alignment: Alignment.center,  // Center align the dropdown items
          // You can add custom padding for the dropdown items
          padding: EdgeInsets.symmetric(vertical: 10.h),
        ),
      ),
    );
  }
}
