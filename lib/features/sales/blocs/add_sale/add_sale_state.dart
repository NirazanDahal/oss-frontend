import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/sales/models/res/add_sale_response_model.dart';

abstract class AddSaleState {}

class AddSaleInitialState extends AddSaleState {}

class AddSaleLoadingState extends AddSaleState {}

class AddSaleSuccessState extends AddSaleState {
  final AddSaleResponseModel response;

  AddSaleSuccessState(this.response);
}

class AddSaleFailureState extends AddSaleState {
  final ErrorResponseModel error;

  AddSaleFailureState(this.error);
}
