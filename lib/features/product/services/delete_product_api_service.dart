import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';

class DeleteProductApiService {
  Future<bool> deleteProduct(String token, String productId) async {
    final url = Uri.parse('${ApiConstants.products}/$productId');
    
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    log('Delete Product Status: ${response.statusCode}');
    
    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      final decoded = jsonDecode(response.body);
      throw Exception(ErrorResponseModel.fromJson(decoded).error);
    }
  }
}
