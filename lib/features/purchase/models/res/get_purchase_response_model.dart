import 'package:oss_frontend/features/purchase/models/res/add_purchase_response_model.dart';

class GetPurchaseResponseModel {
  final bool success;
  final List<PurchaseData> purchases;
  final int totalPages;
  final int currentPage;

  GetPurchaseResponseModel({
    required this.success,
    required this.purchases,
    required this.totalPages,
    required this.currentPage,
  });

  factory GetPurchaseResponseModel.fromJson(Map<String, dynamic> json) {
    return GetPurchaseResponseModel(
      success: json['success'] as bool,
      purchases: (json['data'] as List)
          .map(
            (purchase) =>
                PurchaseData.fromJson(purchase as Map<String, dynamic>),
          )
          .toList(),
      totalPages: json['totalPages'] as int? ?? 1,
      currentPage: json['currentPage'] as int? ?? 1,
    );
  }
}
