
import 'package:oss_frontend/features/auth/models/req/User.dart';

class RegisterResponse {
  final bool success;
  final UserModel? user;
  final String? error;

  RegisterResponse({
    required this.success,
    this.user,
    this.error,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] as bool,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      error: json['error'] as String?,
    );
  }
}