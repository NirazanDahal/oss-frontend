import 'package:oss_frontend/features/sales/models/req/add_sale_request_model.dart';

abstract class AddSaleEvent {}

class AddSaleSubmittedEvent extends AddSaleEvent {
  final AddSaleRequestModel request;

  AddSaleSubmittedEvent(this.request);
}

class ResetAddSaleStateEvent extends AddSaleEvent {}
