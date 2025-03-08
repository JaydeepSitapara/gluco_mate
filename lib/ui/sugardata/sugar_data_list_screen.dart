import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gluco_mate/main.dart';
import 'package:gluco_mate/models/suger_data_model.dart';
import 'package:gluco_mate/providers/sugar_data_provider.dart';
import 'package:gluco_mate/ui/drawer/drawer_widget.dart';
import 'package:gluco_mate/ui/sugardata/add_sugar_data_screen.dart';
import 'package:gluco_mate/ui/sugardata/filter/filter_date_range_widget.dart';
import 'package:gluco_mate/ui/theme/colors.dart';
import 'package:gluco_mate/utils/date_format.dart';
import 'package:gluco_mate/config/injector.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:provider/provider.dart';

class SugarDataListScreen extends StatefulWidget {
  const SugarDataListScreen({super.key});

  @override
  State<SugarDataListScreen> createState() => _SugarDataListScreenState();
}

class _SugarDataListScreenState extends State<SugarDataListScreen> {
  final sugarDataProvider = sl<SugarDataProvider>();

  @override
  void initState() {
    super.initState();

    print('Selected Unit IN LIST :${sl<SugarDataProvider>().selectedUnit}');

    sugarDataProvider.getSugarDataList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        exit(0);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            'Gluco Mate',
            style: appBarTextStyle,
          ),
          actions: [
            InkWell(
              onTap: () {
                navigatorKey.currentState?.push(
                  MaterialPageRoute(
                    builder: (context) => AddSugarDataScreen(
                      isEditSugarData: false,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 8.0.h),
                child: Icon(
                  Icons.add,
                  size: 28.h,
                ),
              ),
            )
          ],
          backgroundColor: whiteColor,
          elevation: 0,
          titleSpacing: 0,
        ),
        drawer: DrawerWidget(),
        body: Consumer<SugarDataProvider>(
          builder: (context, sugarDataProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: const FilterDateRangeWidget(),
                ),
                sugarDataProvider.sugarDataList.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'No Sugar Data. Please add some.',
                            style: montserratStyle(
                                fontSize: 16.sp, color: Colors.grey),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
                          child: ListView.builder(
                            itemCount: sugarDataProvider.sugarDataList.length,
                            itemBuilder: (context, index) {
                              final sugarData =
                                  sugarDataProvider.sugarDataList[index];
                              return _sugarDataCard(
                                sugarData,
                                () {
                                  navigatorKey.currentState?.push(
                                    MaterialPageRoute(
                                      builder: (context) => AddSugarDataScreen(
                                        isEditSugarData: true,
                                        sugarData: sugarData,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _sugarDataCard(SugarData sugarData, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(
            color: Colors.blueGrey.shade100,
            width: 1.w,
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
        shadowColor: Colors.black12,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sugar Value
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${sugarData.sugarValue ?? 0.0}',
                        style: montserratStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          //color: Colors.blueAccent,
                          color: getSugarLevelColor(
                            sugarValue: sugarData.sugarValue ?? 0.0,
                            unit: sugarDataProvider.selectedUnit ?? '',
                          ),
                        ),
                      ),
                      Text(
                        sugarDataProvider.selectedUnit == 'Unit.mgdl'
                            ? ' mg/dL'
                            : ' mmolL',
                        style: montserratStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          //color: Colors.blueAccent,
                          color: getSugarLevelColor(
                            sugarValue: sugarData.sugarValue ?? 0.0,
                            unit: sugarDataProvider.selectedUnit ?? '',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 0.3.w,
                        )),
                    child: Text(
                      sugarData.measured ?? 'Unknown',
                      style: montserratStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // Date & Time
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_today, size: 16.h, color: Colors.grey),
                  SizedBox(width: 4.w),
                  Text(
                    formatDate('${sugarData.date}'),
                    style: montserratStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(width: 12.w),
                  Icon(Icons.access_time, size: 16.h, color: Colors.grey),
                  SizedBox(width: 4.w),
                  Text(
                    '${formatTime('${sugarData.time}')}',
                    //'12:00 PM',
                    style: montserratStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // Notes
              if (sugarData.notes != null && sugarData.notes!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.notes, size: 16.h, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          '${sugarData.notes}',
                          style: montserratStyle(
                              fontSize: 14.sp, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
