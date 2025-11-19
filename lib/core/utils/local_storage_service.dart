import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  String getString(String key) {
    return _preferences.getString(key) ?? "";
  }
}
