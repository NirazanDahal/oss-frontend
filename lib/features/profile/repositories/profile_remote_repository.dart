import 'package:oss_frontend/core/constants/local_storage_constants.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/profile/models/res/profile_response_model.dart';
import 'package:oss_frontend/features/profile/services/profile_api_service.dart';

class ProfileRemoteRepository {
  final ProfileApiService _profileApiService;
  final AuthLocalRepositoty _authLocalRepositoty;
  ProfileRemoteRepository(this._profileApiService, this._authLocalRepositoty);

  Future<ProfileResponseModel> getProfile() async {
    try {
      final token = _authLocalRepositoty.getToken(
        LocalStorageConstants.tokenKey,
      );
      final response = await _profileApiService.getProfile(token);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
