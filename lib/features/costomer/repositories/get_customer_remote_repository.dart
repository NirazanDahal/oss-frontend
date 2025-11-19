import 'package:oss_frontend/core/constants/local_storage_constants.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/costomer/models/res/get_customer_response_model.dart';
import 'package:oss_frontend/features/costomer/services/get_customer_api_service.dart';

class GetCustomerRemoteRepository {
  final GetCustomerApiService _getCustomerApiService;
  final AuthLocalRepositoty _authLocalRepositoty;
  GetCustomerRemoteRepository(
    this._getCustomerApiService,
    this._authLocalRepositoty,
  );

  Future<GetCustomerResponseModel> getCustomer(
    String? search,
    int page,
    int limit,
  ) async {
    try {
      final token = _authLocalRepositoty.getToken(
        LocalStorageConstants.tokenKey,
      );
      final response = await _getCustomerApiService.getCustomer(
        token,
        search,
        page,
        limit,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
