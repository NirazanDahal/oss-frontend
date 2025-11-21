import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/purchase/models/req/update_purchase_request_model.dart';
import 'package:oss_frontend/features/purchase/models/res/update_purchase_response_model.dart';

class UpdatePurchaseApiService {
  final http.Client client;

  UpdatePurchaseApiService(this.client);

  Future<UpdatePurchaseResponseModel> updatePurchase(
    String token,
    String purchaseId,
    UpdatePurchaseRequestModel request,
  ) async {
    final url = Uri.parse('${ApiConstants.purchase}/$purchaseId');

    log('Updating purchase with ID: $purchaseId');
    log('Request: ${jsonEncode(request.toJson())}');

    final response = await client.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.toJson()),
    );

    log('Update purchase response status: ${response.statusCode}');
    log('Update purchase response body: ${response.body}');

    if (response.statusCode == 200) {
      return UpdatePurchaseResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw CreateException(
        ErrorResponseModel.fromJson(jsonDecode(response.body)),
      );
    }
  }
}
