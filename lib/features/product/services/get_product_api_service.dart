import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/product/models/res/get_product_response_model.dart';

class GetProductApiService {
  Future<GetProductResponseModel> getProducts(
    String token, {
    String? search,
    int page = 1,
  }) async {
    final queryParams = {
      'page': page.toString(),
      if (search != null && search.isNotEmpty) 'search': search,
    };
    
    final url = Uri.parse(ApiConstants.products).replace(
      queryParameters: queryParams,
    );
    
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    log('Get Products Status: ${response.statusCode}');
    final decoded = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return GetProductResponseModel.fromJson(decoded);
    } else {
      throw Exception(ErrorResponseModel.fromJson(decoded).error);
    }
  }
}
