import 'package:oss_frontend/core/constants/local_storage_constants.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/costomer/models/res/update_customer_response_model.dart';
import 'package:oss_frontend/features/costomer/services/update_customer_api_service.dart';

class UpdateCustomerRemoteRepository {
  final UpdateCustomerApiService _updateCustomerApiService;
  final AuthLocalRepositoty _authLocalRepositoty;
  UpdateCustomerRemoteRepository(
    this._updateCustomerApiService,
    this._authLocalRepositoty,
  );

  Future<UpdateCustomerResponseModel> updateCustomer(
    String id,
    String name,
    String phone,
    String address,
  ) async {
    try {
      final token = _authLocalRepositoty.getToken(
        LocalStorageConstants.tokenKey,
      );
      final response = await _updateCustomerApiService.updateCustomer(
        token,
        id,
        name,
        phone,
        address,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
