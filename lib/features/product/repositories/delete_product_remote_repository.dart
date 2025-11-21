import 'package:oss_frontend/core/constants/local_storage_constants.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/product/services/delete_product_api_service.dart';

class DeleteProductRemoteRepository {
  final DeleteProductApiService _deleteProductApiService;
  final AuthLocalRepositoty _authLocalRepositoty;
  
  DeleteProductRemoteRepository(
    this._deleteProductApiService,
    this._authLocalRepositoty,
  );

  Future<bool> deleteProduct(String productId) async {
    try {
      final token = _authLocalRepositoty.getToken(
        LocalStorageConstants.tokenKey,
      );
      final response = await _deleteProductApiService.deleteProduct(
        token,
        productId,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
