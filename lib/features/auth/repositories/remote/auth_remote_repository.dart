import 'package:oss_frontend/core/constants/local_storage_constants.dart';
import 'package:oss_frontend/core/utils/local_storage_service.dart';
import 'package:oss_frontend/features/auth/models/res/register_response_model.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/auth/services/auth_api_service.dart';

class AuthRemoteRepository {
  final AuthApiService _authApiService;
  final AuthLocalRepositoty _authLocalRepositoty;

  AuthRemoteRepository(this._authApiService, this._authLocalRepositoty);

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
