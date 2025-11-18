import 'package:dio/dio.dart';
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/features/auth/models/res/login_response.dart';
import 'package:oss_frontend/features/auth/models/res/profile_response.dart';
import 'package:oss_frontend/features/auth/models/res/register_response.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
       ApiConstants.register ,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return RegisterResponse.fromJson(e.response!.data as Map<String, dynamic>);
      }
      // Network error / timeout etc.
      throw Exception(e.message ?? 'Network error');
    }
  }

  Future<LoginResponse> login({
  required String email,
  required String password,
}) async {
  try {
    final response = await _dio.post(
      ApiConstants.login, 
      data: {
        'email': email,
        'password': password,
      },
    );

    return LoginResponse.fromJson(response.data);
  } on DioException catch (e) {
    if (e.response?.data != null) {
      return LoginResponse.fromJson(e.response!.data as Map<String, dynamic>);
    }
    throw Exception(e.message ?? 'Network error');
  }
}


Future<ProfileResponse> getProfile() async {
  try {
    final response = await _dio.get(ApiConstants.profile); 
    return ProfileResponse.fromJson(response.data);
  } on DioException catch (e) {
    if (e.response?.data != null) {
      return ProfileResponse.fromJson(e.response!.data as Map<String, dynamic>);
    }
    rethrow;
  }
}
}