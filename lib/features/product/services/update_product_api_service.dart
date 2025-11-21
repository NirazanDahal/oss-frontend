import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/product/models/req/update_product_request_model.dart';
import 'package:oss_frontend/features/product/models/res/update_product_response_model.dart';

class UpdateProductApiService {
  Future<UpdateProductResponseModel> updateProduct(
    String token,
    String productId,
    String name,
    String batchNo,
    String quantity,
    String purchasePrice,
    String sellingPrice,
  ) async {
    final url = Uri.parse('${ApiConstants.products}/$productId');
    final body = UpdateProductRequestModel(
      name: name,
      batchNo: batchNo,
      quantity: quantity,
      purchasePrice: purchasePrice,
      sellingPrice: sellingPrice,
    );
    
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body.toJson()),
    );
    
    log('Update Product Status: ${response.statusCode}');
    final decoded = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return UpdateProductResponseModel.fromJson(decoded);
    } else {
      throw Exception(ErrorResponseModel.fromJson(decoded).error);
    }
  }
}
