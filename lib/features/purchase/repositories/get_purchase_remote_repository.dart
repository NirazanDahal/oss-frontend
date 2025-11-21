import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/purchase/models/res/get_purchase_response_model.dart';
import 'package:oss_frontend/features/purchase/services/get_purchase_api_service.dart';

class GetPurchaseRemoteRepository {
  final GetPurchaseApiService _getPurchaseApiService;
  final AuthLocalRepositoty _authLocalRepositoty;

  GetPurchaseRemoteRepository(
    this._getPurchaseApiService,
    this._authLocalRepositoty,
  );

  Future<GetPurchaseResponseModel> getPurchases({
    String? search,
    int page = 1,
  }) async {
    try {
      final token = _authLocalRepositoty.getToken('token');
      if (token.isEmpty) {
        throw Exception('Authentication token not found');
      }

      return await _getPurchaseApiService.getPurchases(
        token,
        search: search,
        page: page,
      );
    } catch (e) {
      rethrow;
    }
  }
}
