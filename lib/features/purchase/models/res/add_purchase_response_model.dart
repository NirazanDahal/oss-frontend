class PurchaseProduct {
  final String id;
  final String productName;
  final double rate;
  final int quantity;
  final double lineTotal;

  PurchaseProduct({
    required this.id,
    required this.productName,
    required this.rate,
    required this.quantity,
    required this.lineTotal,
  });

  factory PurchaseProduct.fromJson(Map<String, dynamic> json) {
    return PurchaseProduct(
      id: json['_id'] as String,
      productName: json['productName'] as String,
      rate: (json['rate'] as num).toDouble(),
      quantity: json['quantity'] as int,
      lineTotal: (json['lineTotal'] as num).toDouble(),
    );
  }
}

class PurchaseData {
  final String id;
  final String vendorName;
  final String date;
  final String address;
  final double totalPrice;
  final List<PurchaseProduct> products;
  final String createdAt;
  final String updatedAt;

  PurchaseData({
    required this.id,
    required this.vendorName,
    required this.date,
    required this.address,
    required this.totalPrice,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PurchaseData.fromJson(Map<String, dynamic> json) {
    return PurchaseData(
      id: json['_id'] as String,
      vendorName: json['vendorName'] as String,
      date: json['date'] as String,
      address: json['address'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      products: (json['products'] as List)
          .map((p) => PurchaseProduct.fromJson(p as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}

class AddPurchaseResponseModel {
  final bool success;
  final String message;
  final PurchaseData data;

  AddPurchaseResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddPurchaseResponseModel.fromJson(Map<String, dynamic> json) {
    return AddPurchaseResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: PurchaseData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
