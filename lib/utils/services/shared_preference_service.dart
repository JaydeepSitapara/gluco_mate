import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferenceHelper {
  Future<void> saveString(String key, String value);

  Future<String> getString(String key);

  Future<void> saveBool(String key, bool value);

  Future<bool> getBool(String key);
}

class SharedPreferenceService implements SharedPreferenceHelper {
  @override
  Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  @override
  Future<void> saveString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}

class SharedPreferenceKeys {
  static const String unit = 'unit'; //(mg/dl, mmol/L
  static const String isUnitSelected =
      'isUnitSelected'; //for checking if unit is selected or not
}

enum Unit { mgdl, mmolL }
