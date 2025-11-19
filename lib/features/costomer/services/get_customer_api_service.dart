import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/costomer/models/res/get_customer_response_model.dart';

class GetCustomerApiService {
  Future<GetCustomerResponseModel> getCustomer(
    String token,
    String? search,
    int page,
    int limit,
  ) async {
    final url = Uri.parse(ApiConstants.customer).replace(
      queryParameters: {
        if (search != null && search.isNotEmpty) 'search': search,
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return GetCustomerResponseModel.fromJson(decoded);
    } else {
      throw CreateException(ErrorResponseModel.fromJson(decoded));
    }
  }
}
