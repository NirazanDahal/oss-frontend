import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/purchase/models/req/add_purchase_request_model.dart';
import 'package:oss_frontend/features/purchase/models/res/add_purchase_response_model.dart';

class AddPurchaseApiService {
  final http.Client client;

  AddPurchaseApiService(this.client);

  Future<AddPurchaseResponseModel> addPurchase(
    AddPurchaseRequestModel request,
    String token,
  ) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.purchase),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        return AddPurchaseResponseModel.fromJson(jsonResponse);
      } else {
        final errorResponse = jsonDecode(response.body) as Map<String, dynamic>;
        throw Exception(ErrorResponseModel.fromJson(errorResponse).error);
      }
    } catch (e) {
      if (e.toString().contains('ErrorResponseModel')) {
        rethrow;
      }
      throw Exception('Failed to record purchase: ${e.toString()}');
    }
  }
}
