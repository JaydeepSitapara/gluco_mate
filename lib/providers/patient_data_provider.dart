import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gluco_mate/models/suger_data_model.dart';
import 'package:gluco_mate/utils/database/local_db_provider.dart';
import 'package:gluco_mate/utils/injector.dart';
import 'package:gluco_mate/utils/widgets/show_toast.dart';

class SugarDataProvider extends ChangeNotifier {
  List<SugarData> _sugarDataList = [];

  List<SugarData> get sugarDataList => _sugarDataList;

  final _sugarLevelController = TextEditingController();
  final _notesLevelController = TextEditingController();

  TextEditingController get sugarLevelController => _sugarLevelController;

  TextEditingController get notesLevelController => _notesLevelController;

  String? selectedCondition = 'Morning Before Breakfast';
  TimeOfDay? selectedTime = TimeOfDay.now();
  DateTime? selectedDate = DateTime.now();

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

  Future<int> addSugarData() async {
    try {
      if (_sugarLevelController.text.isEmpty) {
        showSnackbar('Provider Sugar Concentration.');
      } else {
        log('Condition : ${selectedCondition}');
        log('Sugar Level : ${sugarLevelController.text.toString()}');
        log('Notes : ${notesLevelController.text.toString()}');
        log('Date Time : ${selectedDate} -- ${selectedTime} ');

        final sugarData = SugarData(
          measured: '${selectedCondition}',
          sugarValue: double.tryParse(_sugarLevelController.text.trim()),
          notes: '${_notesLevelController.text.trim()}',
          date: '${selectedDate}',
          time: '${selectedTime}',
        );

        final response = await sl<LocalDbProvider>().addSugarData(sugarData);

        showSnackbar('Sugar Data Added.');

        _sugarLevelController.clear();
        _notesLevelController.clear();
        selectedCondition = 'Morning Before Breakfast';
        notifyListeners();

        print('Result: ${response}');

        return response;
      }

      return 0;
    } catch (e) {
      print('Error in add SugarData: ${e.toString()}');

      return 0;
    }
  }

  Future<void> getSugarDataList() async {
    try {
      final list = await sl<LocalDbProvider>().getListSugarData();

      if (list.isNotEmpty) {
        _sugarDataList = list;
        notifyListeners();
      } else {
        _sugarDataList = [];
        print('No Records Found.');
      }
    } catch (e) {
      print('Error in get sugarData list: ${e.toString()}');
    }
  }
}
