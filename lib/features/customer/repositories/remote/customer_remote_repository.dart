
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/features/customer/models/res/customer_response_model.dart';

class CustomerRepository {
  final Dio _dio;
  CustomerRepository(this._dio);

  Future<CustomerResponse> createCustomer({
    required String name,
    required String phone,
    required String address,
  }) async {
    try {
      final response = await _dio.post(ApiConstants.customer, data: {
        'name': name,
        'phone': phone,
        'address': address,
      });
      return CustomerResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return CustomerResponse.fromJson(e.response!.data);
      }
      rethrow;
    }
  }

  Future<CustomerResponse> getCustomers({
    String? search,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };
      if (search != null && search.trim().isNotEmpty) {
        queryParams['search'] = search.trim();
      }

      final response = await _dio.get(ApiConstants.customer, queryParameters: queryParams);
      return CustomerResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data != null) {
        return CustomerResponse.fromJson(e.response!.data);
      }
      rethrow;
    }
  }
}