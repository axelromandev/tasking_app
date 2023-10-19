import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  T? getValue<T>(String key) {
    switch (T) {
      case int:
        return _prefs.getInt(key) as T?;
      case double:
        return _prefs.getDouble(key) as T?;
      case String:
        return _prefs.getString(key) as T?;
      case bool:
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
      case int:
        await _prefs.setInt(key, value as int);
        break;
      case double:
        await _prefs.setDouble(key, value as double);
        break;
      case String:
        await _prefs.setString(key, value as String);
        break;
      case bool:
        await _prefs.setBool(key, value as bool);
        break;
      default:
        throw UnimplementedError(
          'Set not implemented for type ${T.runtimeType}',
        );
    }
  }
}
