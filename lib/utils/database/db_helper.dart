import 'dart:developer';
import 'dart:io';

import 'package:gluco_mate/utils/database/db_info.dart';
import 'package:gluco_mate/utils/database/tables/tables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  Database? _database;

  Database? getDatabase() {
    return _database;
  }

  DbHelper.DBConstrocter();

  static final DbHelper dbHelper = DbHelper.DBConstrocter();

  //getter to get database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    //if not than init database.
    _database = await initDB();
    return _database!;
  }

  //for re-init database
  Future<void> reInitDB() async {
    await _database?.close();
    await initDB();
  }

  // for initialize database
  Future initDB() async {
    //set database to user directory
    Directory userDirectory = await getApplicationDocumentsDirectory();
    String path = join(userDirectory.path, DbInfo.dbName);
    return await openDatabase(path,
        version: DbInfo.dbVersion, onCreate: _onCreate);
  }

  //for create tables.
  Future _onCreate(Database db, int version) async {
    await db.execute(Tables.userTableQuery);
    await db.execute(Tables.sugarDataTableQuery);
    log("--- Table Created! ----");
  }
}
