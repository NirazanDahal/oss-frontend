import 'package:oss_frontend/core/constants/local_storage_constants.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/product/models/res/get_product_response_model.dart';
import 'package:oss_frontend/features/product/services/get_product_api_service.dart';

class GetProductRemoteRepository {
  final GetProductApiService _getProductApiService;
  final AuthLocalRepositoty _authLocalRepositoty;
  
  GetProductRemoteRepository(
    this._getProductApiService,
    this._authLocalRepositoty,
  );

  Future<GetProductResponseModel> getProducts({
    String? search,
    int page = 1,
  }) async {
    try {
      final token = _authLocalRepositoty.getToken(
        LocalStorageConstants.tokenKey,
      );
      final response = await _getProductApiService.getProducts(
        token,
        search: search,
        page: page,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
