import 'package:flutter/material.dart';
import 'package:gluco_mate/ui/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownTextWidget extends StatelessWidget {
  const DropdownTextWidget({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(text ?? '', style: montserratStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
    ),);
  }
}