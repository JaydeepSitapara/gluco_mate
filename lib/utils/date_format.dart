import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(String dateTime) {
  try {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('dd MMM yy').format(parsedDate);
  } catch (e) {
    return 'Invalid Date';
  }
}


String formatTime(String time) {
  try {
    DateTime parsedDate = DateTime.parse(time);
    return DateFormat('hh:mm a').format(parsedDate);
  } catch (e) {
    return 'Invalid Time';
  }
}
