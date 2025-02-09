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

TimeOfDay stringToTimeOfDay(String timeString) {
  List<String> parts = timeString.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}


String formatFullDateTime(String dateTime) {
  try {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
  } catch (e) {
    return 'Invalid DateTime';
  }
}
