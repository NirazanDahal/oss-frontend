import 'package:oss_frontend/features/product/models/res/add_product_response_model.dart';

class UpdateProductResponseModel {
  final bool success;
  final ProductData productData;

  UpdateProductResponseModel({
    required this.success,
    required this.productData,
  });

  factory UpdateProductResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateProductResponseModel(
      success: json['success'],
      productData: ProductData.fromJson(json['data']),
    );
  }
}
