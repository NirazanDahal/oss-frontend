abstract class UpdateCustomerEvent {}

class UpdateCustomerSubmittedEvent extends UpdateCustomerEvent {
  final String id;
  final String name;
  final String phone;
  final String address;

  UpdateCustomerSubmittedEvent(this.id, this.name, this.phone, this.address);
}
