abstract class UpdateCustomerEvent {}

class UpdateCustomerSubmittedEvent extends UpdateCustomerEvent {
  final String name;
  final String phone;
  final String address;

  UpdateCustomerSubmittedEvent(this.name, this.phone, this.address);
}
