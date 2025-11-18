import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late SharedPreferences _preferences;
  static const String tokenKey = 'token';

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setToken(String token) async {
    await _preferences.setString(tokenKey, token);
  }

  String? getToken() {
    return _preferences.getString(tokenKey) ?? "";
  }
}
