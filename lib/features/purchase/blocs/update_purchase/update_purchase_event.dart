import 'package:oss_frontend/features/purchase/models/req/update_purchase_request_model.dart';

abstract class UpdatePurchaseEvent {}

class UpdatePurchaseSubmittedEvent extends UpdatePurchaseEvent {
  final String purchaseId;
  final UpdatePurchaseRequestModel request;

  UpdatePurchaseSubmittedEvent(this.purchaseId, this.request);
}

class ResetUpdatePurchaseStateEvent extends UpdatePurchaseEvent {}
