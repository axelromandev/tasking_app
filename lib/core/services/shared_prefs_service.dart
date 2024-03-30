import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      log('Error', name: 'SharedPrefs', error: e);
    }
  }

  T? getValue<T>(String key) {
    switch (T) {
      case const (int):
        return _prefs.getInt(key) as T?;
      case const (double):
        return _prefs.getDouble(key) as T?;
      case const (String):
        return _prefs.getString(key) as T?;
      case const (bool):
        return _prefs.getBool(key) as T?;
      default:
        throw UnimplementedError(
          'Get not implemented for type ${T.runtimeType}',
        );
    }
  }

  Future<bool> removeKey(String key) async {
    return _prefs.remove(key);
  }

  Future<void> setKeyValue<T>(String key, T value) async {
    switch (T) {
      case const (int):
        await _prefs.setInt(key, value as int);
        break;
      case const (double):
        await _prefs.setDouble(key, value as double);
        break;
      case const (String):
        await _prefs.setString(key, value as String);
        break;
      case const (bool):
        await _prefs.setBool(key, value as bool);
        break;
      default:
        throw UnimplementedError(
          'Set not implemented for type ${T.runtimeType}',
        );
    }
  }
}
