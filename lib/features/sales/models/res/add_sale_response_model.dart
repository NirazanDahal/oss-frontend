class Customer {
  final String id;
  final String name;
  final String phone;
  final String address;
  final int points;
  final String createdAt;
  final String updatedAt;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      points: json['points'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}

class Product {
  final String id;
  final String name;
  final String batchNo;
  final int quantity;
  final double purchasePrice;
  final double sellingPrice;
  final String createdAt;
  final String updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.batchNo,
    required this.quantity,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] as String,
      name: json['name'] as String,
      batchNo: json['batchNo'] as String,
      quantity: json['quantity'] as int,
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}

class SaleProduct {
  final String id;
  final Product product;
  final String batchNo;
  final int quantity;
  final double sellingPrice;

  SaleProduct({
    required this.id,
    required this.product,
    required this.batchNo,
    required this.quantity,
    required this.sellingPrice,
  });

  factory SaleProduct.fromJson(Map<String, dynamic> json) {
    return SaleProduct(
      id: json['_id'] as String,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      batchNo: json['batchNo'] as String,
      quantity: json['quantity'] as int,
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
    );
  }
}

class SaleData {
  final String id;
  final Customer customer;
  final List<SaleProduct> products;
  final double totalAmount;
  final int pointsEarned;
  final String date;
  final String createdAt;
  final String updatedAt;

  SaleData({
    required this.id,
    required this.customer,
    required this.products,
    required this.totalAmount,
    required this.pointsEarned,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SaleData.fromJson(Map<String, dynamic> json) {
    return SaleData(
      id: json['_id'] as String,
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      products: (json['products'] as List)
          .map((p) => SaleProduct.fromJson(p as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      pointsEarned: json['pointsEarned'] as int,
      date: json['date'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}

class AddSaleResponseModel {
  final bool success;
  final String message;
  final SaleData data;
  final int pointsAdded;
  final int customerPoints;

  AddSaleResponseModel({
    required this.success,
    required this.message,
    required this.data,
    required this.pointsAdded,
    required this.customerPoints,
  });

  factory AddSaleResponseModel.fromJson(Map<String, dynamic> json) {
    return AddSaleResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: SaleData.fromJson(json['data'] as Map<String, dynamic>),
      pointsAdded: json['pointsAdded'] as int,
      customerPoints: json['customerPoints'] as int,
    );
  }
}
