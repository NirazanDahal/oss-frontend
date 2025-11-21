import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/purchase/models/req/add_purchase_request_model.dart';
import 'package:oss_frontend/features/purchase/models/res/add_purchase_response_model.dart';
import 'package:oss_frontend/features/purchase/services/add_purchase_api_service.dart';

class AddPurchaseRemoteRepository {
  final AddPurchaseApiService _addPurchaseApiService;
  final AuthLocalRepositoty _authLocalRepositoty;

  AddPurchaseRemoteRepository(
    this._addPurchaseApiService,
    this._authLocalRepositoty,
  );

  Future<AddPurchaseResponseModel> addPurchase(
    AddPurchaseRequestModel request,
  ) async {
    try {
      final token = _authLocalRepositoty.getToken('token');
      if (token.isEmpty) {
        throw Exception('Authentication token not found');
      }

      return await _addPurchaseApiService.addPurchase(request, token);
    } catch (e) {
      rethrow;
    }
  }
}
