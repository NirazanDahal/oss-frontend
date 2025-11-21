import 'package:oss_frontend/features/purchase/models/req/add_purchase_request_model.dart';

abstract class AddPurchaseEvent {}

class AddPurchaseSubmittedEvent extends AddPurchaseEvent {
  final AddPurchaseRequestModel request;

  AddPurchaseSubmittedEvent(this.request);
}

class ResetAddPurchaseStateEvent extends AddPurchaseEvent {}
