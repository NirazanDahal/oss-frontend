abstract class GetCustomerEvent {}

class GetCustomerSubmittedEvent extends GetCustomerEvent {
  final String? search;
  GetCustomerSubmittedEvent({this.search});
}

class GetCustomerLoadMoreEvent extends GetCustomerEvent {}
