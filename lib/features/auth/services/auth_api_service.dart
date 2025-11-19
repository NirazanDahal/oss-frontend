import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/auth/models/res/login_response_model.dart';
import 'package:oss_frontend/features/auth/models/res/register_response_model.dart';

class AuthApiService {
  Future<RegisterResponseModel> register(
    String name,
    String email,
    String password,
  ) async {
    final url = Uri.parse(ApiConstants.register);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return RegisterResponseModel.fromJson(decoded);
    } else {
      throw CreateException(ErrorResponseModel.fromJson(decoded));
    }
  }

  Future<LoginResponseModel> login(String email, String password) async {
    final url = Uri.parse(ApiConstants.login);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(decoded);
    } else {
      throw CreateException(ErrorResponseModel.fromJson(decoded));
    }
  }
}
