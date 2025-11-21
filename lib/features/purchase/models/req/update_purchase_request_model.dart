import 'package:oss_frontend/features/purchase/models/req/add_purchase_request_model.dart';

class UpdatePurchaseRequestModel {
  final String vendorName;
  final String date;
  final String address;
  final List<PurchaseProductRequest> products;

  UpdatePurchaseRequestModel({
    required this.vendorName,
    required this.date,
    required this.address,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'vendorName': vendorName,
      'date': date,
      'address': address,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }
}
