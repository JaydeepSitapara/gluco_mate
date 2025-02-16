import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gluco_mate/providers/sugar_data_provider.dart';
import 'package:gluco_mate/ui/sugardata/filter/filter_date_range_picker.dart';
import 'package:gluco_mate/ui/theme/colors.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:gluco_mate/utils/injector.dart';
import 'package:intl/intl.dart';

class FilterDateRangeWidget extends StatefulWidget {
  const FilterDateRangeWidget({super.key});

  @override
  State<FilterDateRangeWidget> createState() => _FilterDateRangeWidgetState();
}

class _FilterDateRangeWidgetState extends State<FilterDateRangeWidget> {
  final sugarDataProvider = sl<SugarDataProvider>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          backgroundColor: whiteColor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (BuildContext context) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Text(
                      'Filter',
                      style: montserratStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0.h),
                  FilterDateRangePicker(
                    onDateRangeChanged: (
                      DateTime? startDate,
                      DateTime? endDate,
                    ) {
                      sugarDataProvider.startDate = startDate;
                      sugarDataProvider.endDate = endDate;
                    },
                  ),
                ],
              ),
            );
          },
        ).then((_) async {
          if (sugarDataProvider.startDate != null &&
              sugarDataProvider.endDate != null) {
            await sugarDataProvider.getSugarDataList(
              startDate: DateFormat('yyyy-MM-dd')
                  .format(sugarDataProvider.startDate ?? DateTime.now()),
              endDate: DateFormat('yyyy-MM-dd')
                  .format(sugarDataProvider.endDate ?? DateTime.now()),
            );
          } else {
            await sugarDataProvider.getSugarDataList();
          }
          sugarDataProvider.clearFilter();

          //
          //
          // await sugarDataProvider.getSugarDataList(
          //   startDate: DateFormat('yyyy-MM-dd')
          //       .format(sugarDataProvider.startDate ?? DateTime.now()),
          //   endDate: DateFormat('yyyy-MM-dd')
          //       .format(sugarDataProvider.endDate ?? DateTime.now()),
          // );
          //
          // sugarDataProvider.startDate = null;
          // sugarDataProvider.endDate = null;
          //
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: greyColor, width: 1.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filter',
              style: montserratStyle(fontSize: 15.sp),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 22,
              color: blackColor,
            )
          ],
        ),
      ),
    );
  }
}
