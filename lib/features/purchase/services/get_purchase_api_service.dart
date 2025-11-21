import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/purchase/models/res/get_purchase_response_model.dart';

class GetPurchaseApiService {
  final http.Client client;

  GetPurchaseApiService(this.client);

  Future<GetPurchaseResponseModel> getPurchases(
    String token, {
    String? search,
    int page = 1,
  }) async {
    final queryParams = {
      'page': page.toString(),
      if (search != null && search.isNotEmpty) 'search': search,
    };

    final url = Uri.parse(
      ApiConstants.purchase,
    ).replace(queryParameters: queryParams);

    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return GetPurchaseResponseModel.fromJson(decoded);
    } else {
      throw CreateException(ErrorResponseModel.fromJson(decoded));
    }
  }
}
