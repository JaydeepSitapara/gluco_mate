import 'package:flutter/material.dart';

class PatientDataProvider extends ChangeNotifier {

  String? selectedCondition = 'Morning Before Breakfast';
  TimeOfDay? selectedTime;
  DateTime? selectedDate;

  List<DropdownMenuItem<String>> conditionList = const [
    DropdownMenuItem(
      value: 'Morning Before Breakfast',
      child: Text('Morning Before Breakfast'),
    ),
    DropdownMenuItem(
      value: 'Morning After 2 Hours',
      child: Text('Morning After 2 Hours'),
    ),
    DropdownMenuItem(
      value: 'Afternoon Before Lunch',
      child: Text('Afternoon Before Lunch'),
    ),
    DropdownMenuItem(
      value: 'Afternoon After 2 hours',
      child: Text('Afternoon After 2 hours'),
    ),
    DropdownMenuItem(
      value: 'Evening Before Dinner',
      child: Text('Evening Before Dinner'),
    ),
    DropdownMenuItem(
      value: 'Evening After 2 Hours',
      child: Text('Evening After 2 Hours'),
    ),
    DropdownMenuItem(
      value: 'Mid Night',
      child: Text('Mid Night'),
    ),
  ];


  void updateSelectedCondition(String? condition) {
    selectedCondition = condition;
    notifyListeners(); // Notify listeners about the state change
  }

  void updateDate(DateTime? dateTime) {
    selectedDate = dateTime;
    notifyListeners(); // Notify listeners about the state change
  }
  void updateTime(TimeOfDay? timeOfDay) {
    selectedTime = timeOfDay;
    notifyListeners(); // Notify listeners about the state change
  }

}