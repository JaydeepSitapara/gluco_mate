import 'package:flutter/material.dart';

const Color whiteColor = Color(0xFFFFFFFF);
const Color blackColor = Color(0xFF000000);
const Color greyColor = Color(0xFF9E9E9E);

Color getSugarLevelColor(double sugarValue) {
  if (sugarValue < 70) {
    return Colors.redAccent; // Low sugar level
  } else if (sugarValue >= 70 && sugarValue <= 140) {
    return Colors.greenAccent; // Normal range
  } else {
    return Colors.orangeAccent; // High sugar level
  }
}
