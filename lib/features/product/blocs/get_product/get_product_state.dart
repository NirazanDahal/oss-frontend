part of 'get_product_bloc.dart';

abstract class GetProductState {}

class GetProductInitialState extends GetProductState {}

class GetProductLoadingState extends GetProductState {}

class GetProductSuccessState extends GetProductState {
  final List<ProductData> productData;

  GetProductSuccessState(this.productData);
}

class GetProductMoreLoadingState extends GetProductState {
  final List<ProductData> productData;

  GetProductMoreLoadingState(this.productData);
}

class GetProductFailureState extends GetProductState {
  final ErrorResponseModel error;

  GetProductFailureState(this.error);
}
