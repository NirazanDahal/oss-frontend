import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/purchase/models/res/update_purchase_response_model.dart';

abstract class UpdatePurchaseState {}

class UpdatePurchaseInitialState extends UpdatePurchaseState {}

class UpdatePurchaseLoadingState extends UpdatePurchaseState {}

class UpdatePurchaseSuccessState extends UpdatePurchaseState {
  final UpdatePurchaseResponseModel response;

  UpdatePurchaseSuccessState(this.response);
}

class UpdatePurchaseFailureState extends UpdatePurchaseState {
  final ErrorResponseModel error;

  UpdatePurchaseFailureState(this.error);
}
