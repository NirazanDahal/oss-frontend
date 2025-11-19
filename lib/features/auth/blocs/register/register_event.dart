abstract class RegisterEvent {}

class RegisterSubmittedEvent extends RegisterEvent{
  final String name;
  final String email;
  final String password;
  RegisterSubmittedEvent(this.name,this.email,this.password);
}