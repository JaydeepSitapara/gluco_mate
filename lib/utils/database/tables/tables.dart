class Tables {

  static const String sugarDataTable = 'sugarDataTable';
  static const String userTable = 'userTable';

  static const String columnId = 'id';

  //for user table columns
  static const String columnUserName = 'username';
  static const String columnEmail = 'email';
  static const String columnMobile = 'mobile';
  static const String columnBirthDate = 'birthDate';
  static const String columnBloodGroup = 'bloodGroup';
  static const String columnType = 'type'; //diabetes-type

  //for suger-data table columns
  static const String columnSugarValue = 'sugarValue';
  static const String columnDate = 'date';
  static const String columnTime = 'time';
  static const String columnMeasured = 'measured'; //condition
  static const String columnNotes = 'notes';

  static String sugarDataTableQuery = '''
  CREATE TABLE IF NOT EXISTS $sugarDataTable(
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnSugarValue REAL,
    $columnDate DATE,
    $columnTime DATE,
    $columnMeasured TEXT,
    $columnNotes TEXT
    );
  ''';

  static String userTableQuery = '''
  CREATE TABLE IF NOT EXISTS  $userTable (
        $columnId INTEGER PRIMARY KEY,
        $columnUserName TEXT,
        $columnEmail TEXT,
        $columnMobile INTEGER,
        $columnBirthDate DATE,
        $columnBloodGroup TEXT,
        $columnType TEXT
      );
''';

}