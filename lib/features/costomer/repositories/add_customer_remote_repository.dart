import 'package:oss_frontend/core/constants/local_storage_constants.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/costomer/models/res/add_customer_response_model.dart';
import 'package:oss_frontend/features/costomer/services/add_customer_api_service.dart';

class AddCustomerRemoteRepository {
  final AddCustomerApiService _addCustomerApiService;
  final AuthLocalRepositoty _authLocalRepositoty;
  AddCustomerRemoteRepository(
    this._addCustomerApiService,
    this._authLocalRepositoty,
  );

  Future<AddCustomerResponseModel> addCustomer(
    String name,
    String phone,
    String address,
  ) async {
    try {
      final token = _authLocalRepositoty.getToken(
        LocalStorageConstants.tokenKey,
      );
      final response = await _addCustomerApiService.addCustomer(
        token,
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
