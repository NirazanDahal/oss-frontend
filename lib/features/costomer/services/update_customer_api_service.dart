import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/costomer/models/req/update_customer_request_model.dart';
import 'package:oss_frontend/features/costomer/models/res/update_customer_response_model.dart';

class UpdateCustomerApiService {
  Future<UpdateCustomerResponseModel> updateCustomer(
    String token,
    String id,
    String name,
    String phone,
    String address,
  ) async {
    final url = Uri.parse('${ApiConstants.customer}/$id');
    final body = UpdateCustomerRequestModel(
      name: name,
      phone: phone,
      address: address,
    ).toJson();
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return UpdateCustomerResponseModel.fromJson(decoded);
    } else {
      throw CreateException(ErrorResponseModel.fromJson(decoded));
    }
  }
}
