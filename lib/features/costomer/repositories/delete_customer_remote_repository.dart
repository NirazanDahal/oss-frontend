import 'package:oss_frontend/core/constants/local_storage_constants.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/costomer/services/delete_customer_api_service.dart';

class DeleteCustomerRemoteRepository {
  final DeleteCustomerApiService _deleteCustomerApiService;
  final AuthLocalRepositoty _authLocalRepositoty;
  DeleteCustomerRemoteRepository(
    this._deleteCustomerApiService,
    this._authLocalRepositoty,
  );

  Future<void> deleteCustomer(String id) async {
    try {
      final token = _authLocalRepositoty.getToken(
        LocalStorageConstants.tokenKey,
      );
      await _deleteCustomerApiService.deleteCustomer(token, id);
    } catch (e) {
      rethrow;
    }
  }
}
