import 'package:oss_frontend/features/product/models/res/add_product_response_model.dart';

class GetProductResponseModel {
  final bool success;
  final List<ProductData> products;
  final int totalPages;
  final int currentPage;

  GetProductResponseModel({
    required this.success,
    required this.products,
    required this.totalPages,
    required this.currentPage,
  });

  factory GetProductResponseModel.fromJson(Map<String, dynamic> json) {
    return GetProductResponseModel(
      success: json['success'],
      products: (json['data'] as List)
          .map((product) => ProductData.fromJson(product))
          .toList(),
      totalPages: json['totalPages'] ?? 1,
      currentPage: json['currentPage'] ?? 1,
    );
  }
}
