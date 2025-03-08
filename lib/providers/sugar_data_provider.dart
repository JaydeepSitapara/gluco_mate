import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gluco_mate/models/suger_data_model.dart';
import 'package:gluco_mate/ui/widgets/dropdown_text_widget.dart';
import 'package:gluco_mate/config/injector.dart';
import 'package:gluco_mate/ui/widgets/show_toast.dart';
import 'package:gluco_mate/utils/database/local_db_provider.dart';
import 'package:gluco_mate/utils/services/shared_preference_service.dart';
import 'package:intl/intl.dart';

class SugarDataProvider extends ChangeNotifier {
  final localDbProvider = sl<LocalDbProvider>();

  //for filter date range
  DateTime? _startDate;
  DateTime? _endDate;

  DateTime? get startDate => _startDate;

  DateTime? get endDate => _endDate;

  set startDate(DateTime? value) {
    _startDate = value;
  }

  set endDate(DateTime? value) {
    _endDate = value;
  }

  clearFilter() {
    _startDate = null;
    _endDate = null;
  }

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
      child: DropdownTextWidget(text: 'Morning Before Breakfast'),
    ),
    DropdownMenuItem(
      value: 'Morning After 2 Hours',
      child: DropdownTextWidget(text: 'Morning After 2 Hours'),
    ),
    DropdownMenuItem(
      value: 'Afternoon Before Lunch',
      child: DropdownTextWidget(text: 'Afternoon Before Lunch'),
    ),
    DropdownMenuItem(
      value: 'Afternoon After 2 hours',
      child: DropdownTextWidget(text: 'Afternoon After 2 hours'),
    ),
    DropdownMenuItem(
      value: 'Evening Before Dinner',
      child: DropdownTextWidget(text: 'Evening Before Dinner'),
    ),
    DropdownMenuItem(
      value: 'Evening After 2 Hours',
      child: DropdownTextWidget(text: 'Evening After 2 Hours'),
    ),
    DropdownMenuItem(
      value: 'Mid Night',
      child: DropdownTextWidget(text: 'Mid Night'),
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
      final selectedUnit = await sl<SharedPreferenceService>()
              .getString(SharedPreferenceKeys.unit) ??
          '';

      final num? sugarLevel = num.tryParse(_sugarLevelController.text);
      if (sugarLevel == null) {
        showSnackbar('Please enter sugar concentration.');
      } else if (selectedUnit == '${Unit.mmolL}' && sugarLevel < 2.8) {
        showSnackbar('Tow Low!');
      } else if (selectedUnit == '${Unit.mmolL}' && sugarLevel > 27.8) {
        showSnackbar('Tow High!');
      } else if (selectedUnit == '${Unit.mgdl}' && sugarLevel < 50) {
        //mgdl validation
        showSnackbar('Too low!');
      } else if (selectedUnit == '${Unit.mgdl}' && sugarLevel > 500) {
        showSnackbar('Too high!');
      } else if (selectedDate == null) {
        showSnackbar('Please select Date.');
      } else if (selectedTime == null) {
        showSnackbar('Please select Time.');
      } else {
        log('Condition : $selectedCondition');
        log('Sugar Level : ${_sugarLevelController.text.toString()}');
        log('Notes : ${_notesController.text.toString()}');
        log('Date Time : $selectedDate -- $selectedTime ');

        final sugarData = SugarData(
          measured: '$selectedCondition',
          sugarValue: double.tryParse(_sugarLevelController.text.trim()),
          notes: _notesController.text.trim(),
          date: selectedDate != null
              ? DateFormat('yyyy-MM-dd').format(
                  selectedDate ?? DateTime.now()) // Store only 'YYYY-MM-DD'
              : null,
          // date: selectedDate?.toIso8601String(),
          time: DateTime(
                  0, 0, 0, selectedTime?.hour ?? 0, selectedTime?.minute ?? 0)
              .toIso8601String(),
        );

        final response = await localDbProvider.addSugarData(sugarData);

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
          //date: '$selectedDate',
          date: selectedDate != null
              ? DateFormat('yyyy-MM-dd').format(
                  selectedDate ?? DateTime.now()) // Store only 'YYYY-MM-DD'
              : null,
          time:
              '${DateTime(0, 0, 0, selectedTime?.hour ?? 0, selectedTime?.minute ?? 0)}',
        );

        final response =
            await localDbProvider.updateSugarData(sugarData, sugarDataId);

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
      int deletedRows = await localDbProvider.deleteSugarData(sugarDataId);
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

  Future<void> getSugarDataList({String? startDate, String? endDate}) async {
    try {
      final list = await localDbProvider.getListSugarData(
        startDate: startDate,
        endDate: endDate,
      );

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

  String? _selectedUnit = '${Unit.mgdl}';

  String? get selectedUnit => _selectedUnit;

  set selectedUnit(String? value) {
    _selectedUnit = value;
    notifyListeners();
  }
}
