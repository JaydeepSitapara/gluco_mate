import 'package:flutter/material.dart';
import 'package:gluco_mate/ui/theme/colors.dart';

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
