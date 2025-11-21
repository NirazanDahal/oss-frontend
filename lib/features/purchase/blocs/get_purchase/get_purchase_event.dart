abstract class GetPurchaseEvent {}

class GetPurchaseSubmittedEvent extends GetPurchaseEvent {
  final String? search;

  GetPurchaseSubmittedEvent({this.search});
}

class GetPurchaseLoadMoreEvent extends GetPurchaseEvent {}
