import 'dart:developer';

import 'package:oss_frontend/features/costomer/models/res/add_customer_response_model.dart';

class GetCustomerResponseModel {
  final bool success;
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final int count;
  final List<CustomerData> customerData;

  GetCustomerResponseModel({
    required this.success,
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.count,
    required this.customerData,
  });

  factory GetCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    var list = <CustomerData>[];
    if (json['data'] != null) {
      try {
        list = (json['data'] as List)
            .map((item) => CustomerData.fromJson(item as Map<String, dynamic>))
            .toList();
      } catch (e) {
        log('Error parsing customer data: $e');
      }
    }

    return GetCustomerResponseModel(
      success: json['success'] ?? false,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      count: json['count'] ?? 0,
      customerData: list,
    );
  }
}
