part of 'delete_product_bloc.dart';

abstract class DeleteProductState {}

class DeleteProductInitialState extends DeleteProductState {}

class DeleteProductLoadingState extends DeleteProductState {}

class DeleteProductSuccessState extends DeleteProductState {}

class DeleteProductFailureState extends DeleteProductState {
  final ErrorResponseModel error;

  DeleteProductFailureState(this.error);
}
