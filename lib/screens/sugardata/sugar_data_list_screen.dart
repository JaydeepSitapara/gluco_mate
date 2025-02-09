import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gluco_mate/models/suger_data_model.dart';
import 'package:gluco_mate/providers/patient_data_provider.dart';
import 'package:gluco_mate/screens/sugardata/add_sugar_data_screen.dart';
import 'package:gluco_mate/utils/date_format.dart';
import 'package:gluco_mate/utils/injector.dart';
import 'package:gluco_mate/utils/style.dart';
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
        automaticallyImplyLeading: false,
        title: Text(
          'Gluco Mate',
          style: montserratStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: ListView.builder(
                    itemCount: sugarDataProvider.sugarDataList.length,
                    itemBuilder: (context, index) {
                      final sugarData = sugarDataProvider.sugarDataList[index];
                      return _sugarDataCard(sugarData);
                    },
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddSugarDataScreen(),
          ));
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, size: 28, color: Colors.white),
      ),
    );
  }

  Widget _sugarDataCard(SugarData sugarData) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(
            color: Colors.blueGrey.shade100,
            width: 0.5.w,
          )),
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
      elevation: 2,
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
                Text(
                  '${sugarData.sugarValue ?? 0.0} mg/dL',
                  style: montserratStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                          color: Colors.grey.shade400, width: 0.5.w)),
                  child: Text(
                    sugarData.measured ?? 'Unknown',
                    style: montserratStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),

            // Date & Time
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16.h, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  formatDate('${sugarData.date}'),
                  style: montserratStyle(fontSize: 13.sp, color: Colors.grey),
                ),
                SizedBox(width: 12.w),
                Icon(Icons.access_time, size: 16.h, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  //'${formatTime(TimeOfDay(hour: 1, minute: sugarData.time))}',
                  '12:00 PM',
                  style: montserratStyle(fontSize: 13.sp, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 6.h),

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
                            fontSize: 13.sp, color: Colors.black87),
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
    );
  }
}
