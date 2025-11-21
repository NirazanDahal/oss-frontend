import 'package:oss_frontend/features/purchase/models/res/add_purchase_response_model.dart';

class UpdatePurchaseResponseModel {
  final bool success;
  final String message;
  final PurchaseData data;

  UpdatePurchaseResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UpdatePurchaseResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdatePurchaseResponseModel(
      success: json['success'],
      message: json['message'],
      data: PurchaseData.fromJson(json['data']),
    );
  }
}
