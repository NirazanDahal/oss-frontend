part of 'update_product_bloc.dart';

abstract class UpdateProductEvent {}

class UpdateProductSubmittedEvent extends UpdateProductEvent {
  final String productId;
  final String name;
  final String batchNo;
  final String quantity;
  final String purchasePrice;
  final String sellingPrice;

  UpdateProductSubmittedEvent({
    required this.productId,
    required this.name,
    required this.batchNo,
    required this.quantity,
    required this.purchasePrice,
    required this.sellingPrice,
  });
}

class ResetUpdateProductStateEvent extends UpdateProductEvent {}
