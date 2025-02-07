import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gluco_mate/models/suger_data_model.dart';
import 'package:gluco_mate/utils/database/db_helper.dart';
import 'package:gluco_mate/utils/database/tables/tables.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbProvider extends ChangeNotifier {
  Future<int> addSugarData(SugarData sugarData) async {
    try {

      Database? db = await DbHelper.dbHelper
          .database;

      final response = db
          .insert(Tables.sugarDataTable, sugarData.toMap());

      return response;
    } catch (e) {
      log('Error in add sugar data: ${e.toString()}');
      return 0;
    }
  }
}
