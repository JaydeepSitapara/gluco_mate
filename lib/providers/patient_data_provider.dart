import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gluco_mate/models/suger_data_model.dart';
import 'package:gluco_mate/utils/database/local_db_provider.dart';
import 'package:gluco_mate/utils/injector.dart';
import 'package:gluco_mate/ui/widgets/show_toast.dart';

class SugarDataProvider extends ChangeNotifier {
  List<SugarData> _sugarDataList = [];

  List<SugarData> get sugarDataList => _sugarDataList;

  final _sugarLevelController = TextEditingController();
  final _notesController = TextEditingController();

  TextEditingController get sugarLevelController => _sugarLevelController;

  TextEditingController get notesController => _notesController;

  updateSugarValue(String sugarValue) {
    _sugarLevelController.text = sugarValue.toString();
  }

  updateNotes(String notes) {
    _notesController.text = notes;
  }

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
    notifyListeners();
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
        log('Condition : $selectedCondition');
        log('Sugar Level : ${_sugarLevelController.text.toString()}');
        log('Notes : ${_notesController.text.toString()}');
        log('Date Time : $selectedDate -- $selectedTime ');

        final sugarData = SugarData(
          measured: '$selectedCondition',
          sugarValue: double.tryParse(_sugarLevelController.text.trim()),
          notes: _notesController.text.trim(),
          date: selectedDate?.toIso8601String(),
          time: DateTime(
                  0, 0, 0, selectedTime?.hour ?? 0, selectedTime?.minute ?? 0)
              .toIso8601String(),
        );

        final response = await sl<LocalDbProvider>().addSugarData(sugarData);

        showSnackbar('Sugar Data Added.');

        _sugarLevelController.clear();
        _notesController.clear();
        selectedCondition = 'Morning Before Breakfast';
        notifyListeners();

        print('Result: $response');

        return response;
      }

      return 0;
    } catch (e) {
      print('Error in add SugarData: ${e.toString()}');

      return 0;
    }
  }

  Future<int> updateSugarData(int sugarDataId) async {
    try {
      if (_sugarLevelController.text.isEmpty) {
        showSnackbar('Provider Sugar Concentration.');
        return 0;
      } else {
        log('Condition : $selectedCondition');
        log('Sugar Level : ${_sugarLevelController.text.toString()}');
        log('Notes : ${_notesController.text.toString()}');
        log('Date Time : $selectedDate -- $selectedTime ');

        final sugarData = SugarData(
          measured: '$selectedCondition',
          sugarValue: double.tryParse(_sugarLevelController.text.trim()),
          notes: _notesController.text.trim(),
          date: '$selectedDate',
          time:
          '${DateTime(0, 0, 0, selectedTime?.hour ?? 0, selectedTime?.minute ?? 0)}',
        );

        final response =
        await sl<LocalDbProvider>().updateSugarData(sugarData, sugarDataId);

        if (response > 0) {
          showSnackbar('Sugar Data Updated.');
          print('Record updated successfully');
        }

        _sugarLevelController.clear();
        _notesController.clear();
        selectedCondition = 'Morning Before Breakfast';
        notifyListeners();

        return response;
      }
    } catch (e) {
      log('error in update sugarData: ${e.toString()}');

      return 0;
    }
  }

  Future<int> deleteSugarData(int sugarDataId) async {
    try {
      int deletedRows =
          await sl<LocalDbProvider>().deleteSugarData(sugarDataId);
      if (deletedRows > 0) {
        showSnackbar('Record deleted successfully.');
        print('Record deleted successfully');

        return deletedRows;
      }
      return 0;
    } catch (e) {
      log('Error in delete SugarData: ${e.toString()}');

      return 0;
    }
  }

  Future<void> getSugarDataList() async {
    try {
      final list = await sl<LocalDbProvider>().getListSugarData();

      if (list.isNotEmpty) {
        _sugarDataList = list;
      } else {
        _sugarDataList = [];
        print('No Records Found.');
      }

      notifyListeners();
    } catch (e) {
      print('Error in get sugarData list: ${e.toString()}');
    }
  }
}
