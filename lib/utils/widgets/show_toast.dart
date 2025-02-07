import 'package:flutter/material.dart';
import 'package:gluco_mate/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showSnackbar(String message) {
  final context = navigatorKey.currentContext;
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 3.h),
        behavior: SnackBarBehavior.floating,
        content: Text(message),

      ),
    );
  }
}
