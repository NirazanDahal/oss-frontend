abstract class DeleteCustomerEvent {}

class DeleteCustomerSubmittedEvent extends DeleteCustomerEvent {
  final String id;
  DeleteCustomerSubmittedEvent(this.id);
}
