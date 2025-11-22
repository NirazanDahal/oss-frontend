import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/sales/models/req/add_sale_request_model.dart';
import 'package:oss_frontend/features/sales/models/res/add_sale_response_model.dart';

class AddSaleApiService {
  final http.Client client;

  AddSaleApiService(this.client);

  Future<AddSaleResponseModel> addSale(
    AddSaleRequestModel request,
    String token,
  ) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.sales),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        return AddSaleResponseModel.fromJson(jsonResponse);
      } else {
        final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
        throw Exception(ErrorResponseModel.fromJson(errorResponse).error);
      }
    } catch (e) {
      if (e.toString().contains('ErrorResponseModel')) {
        rethrow;
      }
      throw Exception('Failed to record sale: ${e.toString()}');
    }
  }
}
