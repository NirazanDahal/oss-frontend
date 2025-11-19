import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/costomer/models/res/add_customer_response_model.dart';

abstract class AddCustomerState {}

class AddCustomerInitialState extends AddCustomerState {}

class AddCustomerLoadingState extends AddCustomerState {}

class AddCustomerSuccessState extends AddCustomerState {
  final AddCustomerResponseModel addCustomerResponse;
  AddCustomerSuccessState(this.addCustomerResponse);
}

class AddCustomerFailureState extends AddCustomerState {
  final ErrorResponseModel error;
  AddCustomerFailureState(this.error);
}
