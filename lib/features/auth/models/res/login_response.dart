
import 'package:oss_frontend/features/auth/models/req/User.dart';

class LoginResponse {
  final bool success;
  final String? token;
  final UserModel? user;
  final String? error;

  LoginResponse({
    required this.success,
    this.token,
    this.user,
    this.error,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] as bool,
      token: json['token'] as String?,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      error: json['error'] as String?,
    );
  }
}