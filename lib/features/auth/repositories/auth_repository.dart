import 'package:oss_frontend/core/utils/local_storage_service.dart';
import 'package:oss_frontend/features/auth/models/res/register_response_model.dart';
import 'package:oss_frontend/features/auth/services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService _authApiService;
  final LocalStorageService _localStorageService;
  AuthRepository(this._authApiService, this._localStorageService);
  Future<RegisterResponseModel> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await _authApiService.register(name, email, password);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
