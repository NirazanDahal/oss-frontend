import 'package:oss_frontend/core/constants/local_storage_constants.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/product/models/res/update_product_response_model.dart';
import 'package:oss_frontend/features/product/services/update_product_api_service.dart';

class UpdateProductRemoteRepository {
  final UpdateProductApiService _updateProductApiService;
  final AuthLocalRepositoty _authLocalRepositoty;
  
  UpdateProductRemoteRepository(
    this._updateProductApiService,
    this._authLocalRepositoty,
  );

  Future<UpdateProductResponseModel> updateProduct(
    String productId,
    String name,
    String batchNo,
    String quantity,
    String purchasePrice,
    String sellingPrice,
  ) async {
    try {
      final token = _authLocalRepositoty.getToken(
        LocalStorageConstants.tokenKey,
      );
      final response = await _updateProductApiService.updateProduct(
        token,
        productId,
        name,
        batchNo,
        quantity,
        purchasePrice,
        sellingPrice,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
