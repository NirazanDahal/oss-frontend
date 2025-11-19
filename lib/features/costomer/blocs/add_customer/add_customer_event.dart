abstract class AddCustomerEvent {}

class AddCustomerSubmittedEvent extends AddCustomerEvent {
  final String name;
  final String phone;
  final String address;
  AddCustomerSubmittedEvent(this.name, this.phone, this.address);
}

class ResetAddCustomerStateEvent extends AddCustomerEvent {}
