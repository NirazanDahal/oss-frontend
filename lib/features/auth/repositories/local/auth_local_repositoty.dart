import 'package:oss_frontend/core/utils/local_storage_service.dart';

class AuthLocalRepositoty {
  final LocalStorageService _localStorageService;
  AuthLocalRepositoty(this._localStorageService);

  Future<void> saveToken(String key, String token) async {
    await _localStorageService.setString(key, token);
  }

  String getToken(String key) {
    return _localStorageService.getString(key);
  }

  Future<void> clearAll() async {
    return await _localStorageService.clearAll();
  }
}
