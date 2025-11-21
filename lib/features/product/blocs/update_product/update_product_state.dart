part of 'update_product_bloc.dart';

abstract class UpdateProductState {}

class UpdateProductInitialState extends UpdateProductState {}

class UpdateProductLoadingState extends UpdateProductState {}

class UpdateProductSuccessState extends UpdateProductState {
  final UpdateProductResponseModel response;

  UpdateProductSuccessState(this.response);
}

class UpdateProductFailureState extends UpdateProductState {
  final ErrorResponseModel error;

  UpdateProductFailureState(this.error);
}
