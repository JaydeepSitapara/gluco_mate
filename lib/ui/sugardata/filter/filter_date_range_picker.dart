import 'package:flutter/material.dart';
import 'package:gluco_mate/ui/theme/colors.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterDateRangePicker extends StatefulWidget {
  final Function(DateTime?, DateTime?) onDateRangeChanged;

  const FilterDateRangePicker({super.key, required this.onDateRangeChanged});

  @override
  State<FilterDateRangePicker> createState() => _FilterDateRangePickerState();
}

class _FilterDateRangePickerState extends State<FilterDateRangePicker> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteColor,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Date Range', style: montserratStyle(fontSize: 14.sp)),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: _buildDateField(
                    controller: _startDateController,
                    label: 'Start Date',
                    hint: 'Pick a date',
                    firstDate: DateTime.now(),
                    selectedDate: selectedStartDate,
                    onChange: (DateTime selectedDate) {
                      setState(() {
                        selectedStartDate = selectedDate;
                        selectedEndDate =
                            null; // Reset end date if start changes
                        _endDateController.clear();
                        widget.onDateRangeChanged(
                            selectedStartDate, selectedEndDate);
                      });
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildDateField(
                    controller: _endDateController,
                    label: 'End Date',
                    hint: 'Pick a date',
                    firstDate: selectedStartDate ?? DateTime.now(),
                    selectedDate: selectedEndDate,
                    enabled: selectedStartDate != null,
                    onChange: (DateTime selectedDate) {
                      setState(() {
                        selectedEndDate = selectedDate;
                        widget.onDateRangeChanged(
                            selectedStartDate, selectedEndDate);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required DateTime firstDate,
    DateTime? selectedDate,
    bool enabled = true,
    required Function(DateTime) onChange,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      enabled: enabled,
      style: montserratStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: montserratStyle(fontSize: 12.sp),
        hintStyle: montserratStyle(fontSize: 12.sp),
        prefixIcon: enabled
            ? IconButton(
                onPressed: () async {
                  await _showDatePickerDialog(firstDate, controller, onChange);
                },
                icon: const Icon(
                  Icons.calendar_today,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: greyColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: greyColor, width: 2),
        ),
      ),
      onTap: enabled
          ? () async {
              await _showDatePickerDialog(firstDate, controller, onChange);
            }
          : null,
    );
  }

  Future<void> _showDatePickerDialog(
    DateTime firstDate,
    TextEditingController controller,
    Function(DateTime) onChange,
  ) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1999),
      lastDate: DateTime(2999),
    );
    if (selectedDate != null) {
      onChange(selectedDate);
      controller.text = DateFormat('dd MMM yy').format(selectedDate);
      //controller.text = DateFormat.yMMMd().format(selectedDate);
    }
  }
}
