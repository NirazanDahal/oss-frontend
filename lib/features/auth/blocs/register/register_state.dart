import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/auth/models/res/register_response_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final RegisterResponseModel registerResponse;
  RegisterSuccessState(this.registerResponse);
}

class RegisterFailureState extends RegisterState {
  final ErrorResponseModel error;
  RegisterFailureState(this.error);
}
