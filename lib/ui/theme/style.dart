import 'package:flutter/material.dart';
import 'package:gluco_mate/ui/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle montserratStyle({
  double? fontSize,
  FontWeight fontWeight = FontWeight.normal,
  Color color = blackColor,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: 'Montserrat',
    color: color,
  );
}

TextStyle appBarTextStyle = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
  color: blackColor,
);

TextStyle titleTextStyle = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  fontFamily: 'Montserrat',
  color: blackColor,
);


TextStyle largeTextStyle = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  fontFamily: 'Montserrat',
  color: blackColor,
);

TextStyle largeTextStyle1   = TextStyle(
  fontSize: 34.sp,
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat',
  color: blackColor,
);




