class SaleProductRequest {
  final String product;
  final int quantity;

  SaleProductRequest({
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'quantity': quantity,
    };
  }
}

class AddSaleRequestModel {
  final String customerId;
  final List<SaleProductRequest> products;

  AddSaleRequestModel({
    required this.customerId,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }
}
