import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/costomer/models/res/add_customer_response_model.dart';

abstract class UpdateCustomerState {}

class UpdateCustomerInitialState extends UpdateCustomerState {}

class UpdateCustomerLoadingState extends UpdateCustomerState {}

class UpdateCustomerSuccessState extends UpdateCustomerState {
  final CustomerData customerData;
  UpdateCustomerSuccessState(this.customerData);
}

class UpdateCustomerFailureState extends UpdateCustomerState {
  final ErrorResponseModel errorResponse;
  UpdateCustomerFailureState(this.errorResponse);
}
