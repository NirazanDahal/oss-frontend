import 'package:oss_frontend/core/utils/error_response_model.dart';

abstract class DeleteCustomerState {}

class DeleteCustomerInitialState extends DeleteCustomerState {}

class DeleteCustomerLoadingState extends DeleteCustomerState {}

class DeleteCustomerSuccessState extends DeleteCustomerState {}

class DeleteCustomerFailureState extends DeleteCustomerState {
  final ErrorResponseModel errorResponse;
  DeleteCustomerFailureState(this.errorResponse);
}
