import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/costomer/models/req/add_customer_request_model.dart';
import 'package:oss_frontend/features/costomer/models/res/add_customer_response_model.dart';

class AddCustomerApiService {
  Future<AddCustomerResponseModel> addCustomer(
    String token,
    String name,
    String phone,
    String address,
  ) async {
    final url = Uri.parse(ApiConstants.customer);
    final body = AddCustomerRequestModel(
      name: name,
      phone: phone,
      address: address,
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body.toJson()),
    );
    log(response.statusCode.toString());
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return AddCustomerResponseModel.fromJson(decoded);
    } else {
      throw CreateException(ErrorResponseModel.fromJson(decoded));
    }
  }
}
