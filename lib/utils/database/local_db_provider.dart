import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gluco_mate/models/suger_data_model.dart';
import 'package:gluco_mate/utils/database/db_helper.dart';
import 'package:gluco_mate/utils/database/tables/tables.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbProvider extends ChangeNotifier {
  Future<int> addSugarData(SugarData sugarData) async {
    try {
      Database? db = await DbHelper.dbHelper.database;
      final response = db.insert(Tables.sugarDataTable, sugarData.toMap());
      return response;
    } catch (e) {
      log('Error in add sugar data: ${e.toString()}');
      return 0;
    }
  }

  Future<int> updateSugarData(SugarData sugarData, int sugarDataId) async {
    try {
      Database? db = await DbHelper.dbHelper.database;

      int response = await db.rawUpdate(
        '''
      UPDATE ${Tables.sugarDataTable} 
      SET 
        ${Tables.columnSugarValue} = ?, 
        ${Tables.columnDate} = ?, 
        ${Tables.columnTime} = ?,
        ${Tables.columnMeasured} = ?,
        ${Tables.columnNotes} = ? 
      WHERE id = ?
      ''',
        [
          sugarData.sugarValue,
          sugarData.date,
          sugarData.time,
          sugarData.measured,
          sugarData.notes,
          sugarDataId
        ],
      );

      return response;
    } catch (e) {
      log('Error in updating sugar data: ${e.toString()}');
      return 0; // Return 0 if update fails
    }
  }

  Future<int> deleteSugarData(int sugarDataId) async {
    try {
      Database? db = await DbHelper.dbHelper.database;

      String query = '''
      DELETE FROM ${Tables.sugarDataTable} WHERE id = ?;
    ''';

      int response = await db.rawDelete(query, [sugarDataId]);

      return response;
    } catch (e) {
      log('Error in delete sugarData: ${e.toString()}');
      return 0;
    }
  }

  Future<List<SugarData>> getListSugarData(
      {String? startDate, String? endDate}) async {
    try {
      Database? db = await DbHelper.dbHelper.database;

      String query = 'SELECT * FROM ${Tables.sugarDataTable}';
      List<dynamic> args = [];

      if (startDate != null &&
          startDate.isNotEmpty &&
          endDate != null &&
          endDate.isNotEmpty) {
        print('Start Date: ${startDate} - end Data: ${endDate}');

        query +=
            ' WHERE ${Tables.columnDate} BETWEEN ? AND ? ORDER BY ${Tables.columnDate} ASC';
        args = [startDate, endDate];
      } else {
        query +=
            ' ORDER BY ${Tables.columnDate} ASC'; // Fetch all if no date range
      }

      final response = await db.rawQuery(query, args);

      List<SugarData> _sugarDataList = response.isNotEmpty
          ? response.map((c) => SugarData.fromMap(c)).toList()
          : [];
      notifyListeners();

      print('Filtered SugarData List Length: ${_sugarDataList.length}');
      return _sugarDataList;
    } catch (e) {
      log('Error fetching sugar data: ${e.toString()}');
      return [];
    }
  }

// Future<List<SugarData>> getListSugarData() async {
//   try {
//     Database? db = await DbHelper.dbHelper.database;
//
//     final response = await db.query(Tables.sugarDataTable);
//
//     List<SugarData> _sugarDataList = response.isNotEmpty
//         ? response.map((c) => SugarData.fromMap(c)).toList()
//         : [];
//     notifyListeners();
//
//     print('SugarData List Length: ${_sugarDataList.length}');
//
//     return _sugarDataList;
//   } catch (e) {
//     log('Error in get list of sugar data: ${e.toString()}');
//
//     return [];
//   }
// }
}
