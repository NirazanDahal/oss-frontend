class UpdateProductRequestModel {
  final String name;
  final String batchNo;
  final String quantity;
  final String purchasePrice;
  final String sellingPrice;

  UpdateProductRequestModel({
    required this.name,
    required this.batchNo,
    required this.quantity,
    required this.purchasePrice,
    required this.sellingPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'batchNo': batchNo,
      'quantity': quantity,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
    };
  }
}
