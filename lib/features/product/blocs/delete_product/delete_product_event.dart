part of 'delete_product_bloc.dart';

abstract class DeleteProductEvent {}

class DeleteProductSubmittedEvent extends DeleteProductEvent {
  final String productId;

  DeleteProductSubmittedEvent(this.productId);
}

class ResetDeleteProductStateEvent extends DeleteProductEvent {}
