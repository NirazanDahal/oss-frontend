import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/core/utils/exception_utils.dart';
import 'package:oss_frontend/features/auth/models/res/login_response_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginResponseModel loginResponse;
  LoginSuccessState(this.loginResponse);
}

class LoginFailureState extends LoginState {
  final ErrorResponseModel error;
  LoginFailureState(this.error);
}
