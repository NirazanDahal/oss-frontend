import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/purchase/models/res/add_purchase_response_model.dart';

abstract class GetPurchaseState {}

class GetPurchaseInitialState extends GetPurchaseState {}

class GetPurchaseLoadingState extends GetPurchaseState {}

class GetPurchaseSuccessState extends GetPurchaseState {
  final List<PurchaseData> purchaseData;

  GetPurchaseSuccessState(this.purchaseData);
}

class GetPurchaseMoreLoadingState extends GetPurchaseState {
  final List<PurchaseData> purchaseData;

  GetPurchaseMoreLoadingState(this.purchaseData);
}

class GetPurchaseFailureState extends GetPurchaseState {
  final ErrorResponseModel error;

  GetPurchaseFailureState(this.error);
}
