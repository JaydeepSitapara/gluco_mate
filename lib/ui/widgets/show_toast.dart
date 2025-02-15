import 'package:flutter/material.dart';
import 'package:gluco_mate/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gluco_mate/ui/theme/style.dart';

showSnackbar(String message) {
  final context = navigatorKey.currentContext;
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 3.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: montserratStyle(color: Colors.white),
        ),
      ),
    );
  }
}
