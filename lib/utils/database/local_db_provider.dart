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

  Future<List<SugarData>> getListSugarData() async {
    try {
      Database? db = await DbHelper.dbHelper.database;

      final response = await db.query(Tables.sugarDataTable);

      List<SugarData> _sugarDataList = response.isNotEmpty
          ? response.map((c) => SugarData.fromMap(c)).toList()
          : [];
      notifyListeners();

      print('SugarData List Length: ${_sugarDataList.length}');

      return _sugarDataList;
    } catch (e) {
      log('Error in get list of sugar data: ${e.toString()}');

      return [];
    }
  }
}
