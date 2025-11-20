abstract class LoginEvent {}

class LoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmittedEvent(this.email, this.password);
}

class LoginStatusCheckEvent extends LoginEvent {}

class LogoutEvent extends LoginEvent {}
