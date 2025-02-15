import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gluco_mate/models/suger_data_model.dart';
import 'package:gluco_mate/providers/patient_data_provider.dart';
import 'package:gluco_mate/ui/sugardata/add_sugar_data_screen.dart';
import 'package:gluco_mate/ui/theme/colors.dart';
import 'package:gluco_mate/utils/date_format.dart';
import 'package:gluco_mate/utils/injector.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:provider/provider.dart';

class SugarDataListScreen extends StatefulWidget {
  @override
  State<SugarDataListScreen> createState() => _SugarDataListScreenState();
}

class _SugarDataListScreenState extends State<SugarDataListScreen> {
  @override
  void initState() {
    super.initState();
    sl<SugarDataProvider>().getSugarDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Gluco Mate',
          style: montserratStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
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
      drawer: Drawer(
        backgroundColor: whiteColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Gluco Mate",
                    style: montserratStyle(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.file_copy),
              title: Text(
                'Reports',
                style: montserratStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close Drawer
              },
            ),
          ],
        ),
      ),
      body: Consumer<SugarDataProvider>(
        builder: (context, sugarDataProvider, child) {
          return sugarDataProvider.sugarDataList.isEmpty
              ? Center(
                  child: Text(
                    'No Sugar Data. Please add some.',
                    style: montserratStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: ListView.builder(
                    itemCount: sugarDataProvider.sugarDataList.length,
                    itemBuilder: (context, index) {
                      final sugarData = sugarDataProvider.sugarDataList[index];
                      return _sugarDataCard(
                        sugarData,
                        () {
                          Navigator.of(context).push(
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
                );
        },
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
                          color:
                              getSugarLevelColor(sugarData.sugarValue ?? 0.0),
                        ),
                      ),
                      Text(
                        ' mg/dL',
                        style: montserratStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          //color: Colors.blueAccent,
                          color:
                              getSugarLevelColor(sugarData.sugarValue ?? 0.0),
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
                            color: Colors.grey.shade400, width: 0.3.w)),
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
