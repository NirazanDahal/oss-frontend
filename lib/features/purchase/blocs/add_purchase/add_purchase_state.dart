import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/purchase/models/res/add_purchase_response_model.dart';

abstract class AddPurchaseState {}

class AddPurchaseInitialState extends AddPurchaseState {}

class AddPurchaseLoadingState extends AddPurchaseState {}

class AddPurchaseSuccessState extends AddPurchaseState {
  final AddPurchaseResponseModel response;

  AddPurchaseSuccessState(this.response);
}

class AddPurchaseFailureState extends AddPurchaseState {
  final ErrorResponseModel error;

  AddPurchaseFailureState(this.error);
}
