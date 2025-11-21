class PurchaseProductRequest {
  final String productName;
  final double rate;
  final int quantity;

  PurchaseProductRequest({
    required this.productName,
    required this.rate,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {'productName': productName, 'rate': rate, 'quantity': quantity};
  }
}

class AddPurchaseRequestModel {
  final String vendorName;
  final String date;
  final String address;
  final List<PurchaseProductRequest> products;

  AddPurchaseRequestModel({
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
