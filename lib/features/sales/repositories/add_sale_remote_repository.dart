import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/sales/models/req/add_sale_request_model.dart';
import 'package:oss_frontend/features/sales/models/res/add_sale_response_model.dart';
import 'package:oss_frontend/features/sales/services/add_sale_api_service.dart';

class AddSaleRemoteRepository {
  final AddSaleApiService _addSaleApiService;
  final AuthLocalRepositoty _authLocalRepositoty;

  AddSaleRemoteRepository(
    this._addSaleApiService,
    this._authLocalRepositoty,
  );

  Future<AddSaleResponseModel> addSale(
    AddSaleRequestModel request,
  ) async {
    try {
      final token = _authLocalRepositoty.getToken('token');
      if (token.isEmpty) {
        throw Exception('Authentication token not found');
      }

      return await _addSaleApiService.addSale(request, token);
    } catch (e) {
      rethrow;
    }
  }
}
