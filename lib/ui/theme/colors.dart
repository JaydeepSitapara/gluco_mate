import 'package:flutter/material.dart';

const Color whiteColor = Color(0xFFFFFFFF);
const Color blackColor = Color(0xFF000000);
const Color greyColor = Color(0xFF9E9E9E);

const Color blueAccent = Color(0xFF2196F3);

Color getSugarLevelColor({double sugarValue = 0.0, String unit = 'Unit.mdgl'}) {
  if (unit == 'Unit.mdgl') {
    if (sugarValue < 3.9) {
      return Colors.redAccent;
    } else if (sugarValue >= 3.9 && sugarValue <= 7.8) {
      return Colors.greenAccent;
    } else {
      return Colors.orangeAccent;
    }
  } else {

    if (sugarValue < 3.9) {
      return Colors.redAccent;
    } else if (sugarValue >= 3.9 && sugarValue <= 7.8) {
      return Colors.greenAccent;
    } else {
      return Colors.orangeAccent;
    }

  }
}
