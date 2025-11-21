part of 'add_product_bloc.dart';

abstract class AddProductState {}

class AddProductInitialState extends AddProductState {}

class AddProductLoadingState extends AddProductState {}

class AddProductSuccessState extends AddProductState {
  final AddProductResponseModel response;

  AddProductSuccessState(this.response);
}

class AddProductFailureState extends AddProductState {
  final ErrorResponseModel error;

  AddProductFailureState(this.error);
}
