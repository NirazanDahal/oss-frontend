import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/profile/models/res/profile_response_model.dart';

class ProfileApiService {
  Future<ProfileResponseModel> getProfile(String token) async {
    final url = Uri.parse(ApiConstants.profile);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ProfileResponseModel.formJson(decoded);
    } else {
      throw CreateException(ErrorResponseModel.fromJson(decoded));
    }
  }
}
