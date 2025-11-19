import 'package:oss_frontend/features/auth/models/res/register_response_model.dart';

class LoginResponseModel {
  final bool success;
  final String token;
  final User user;

  LoginResponseModel({
    required this.success,
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
