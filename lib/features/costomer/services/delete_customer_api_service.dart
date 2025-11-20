import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';

class DeleteCustomerApiService {
  Future<void> deleteCustomer(String token, String id) async {
    final url = Uri.parse('${ApiConstants.customer}/$id');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final decoded = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw CreateException(ErrorResponseModel.fromJson(decoded));
    }
  }
}
