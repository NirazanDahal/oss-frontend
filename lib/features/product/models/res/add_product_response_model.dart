class AddProductResponseModel {
  final bool success;
  final ProductData productData;

  AddProductResponseModel({
    required this.success,
    required this.productData,
  });

  factory AddProductResponseModel.fromJson(Map<String, dynamic> json) {
    return AddProductResponseModel(
      success: json['success'],
      productData: ProductData.fromJson(json['data']),
    );
  }
}

class ProductData {
  final String name;
  final String batchNo;
  final int quantity;
  final int purchasePrice;
  final int sellingPrice;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ProductData({
    required this.name,
    required this.batchNo,
    required this.quantity,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      name: json['name'],
      batchNo: json['batchNo'],
      quantity: json['quantity'],
      purchasePrice: json['purchasePrice'],
      sellingPrice: json['sellingPrice'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'batchNo': batchNo,
      'quantity': quantity,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
