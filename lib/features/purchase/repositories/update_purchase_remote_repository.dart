import 'package:oss_frontend/core/constants/local_storage_constants.dart';
import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/purchase/models/req/update_purchase_request_model.dart';
import 'package:oss_frontend/features/purchase/models/res/update_purchase_response_model.dart';
import 'package:oss_frontend/features/purchase/services/update_purchase_api_service.dart';

class UpdatePurchaseRemoteRepository {
  final UpdatePurchaseApiService _apiService;
  final AuthLocalRepositoty _authLocalRepositoty;

  UpdatePurchaseRemoteRepository(this._apiService, this._authLocalRepositoty);

  Future<UpdatePurchaseResponseModel> updatePurchase(
    String purchaseId,
    UpdatePurchaseRequestModel request,
  ) async {
    try {
      final token = _authLocalRepositoty.getToken(
        LocalStorageConstants.tokenKey,
      );
      final response = await _apiService.updatePurchase(
        token,
        purchaseId,
        request,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
