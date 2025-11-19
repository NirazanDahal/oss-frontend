import 'package:oss_frontend/core/utils/error_response_model.dart';
import 'package:oss_frontend/features/costomer/models/res/add_customer_response_model.dart';
import 'package:oss_frontend/features/costomer/models/res/get_customer_response_model.dart';

abstract class GetCustomerState {}

class GetCustomerInitialState extends GetCustomerState {}

class GetCustomerLoadingState extends GetCustomerState {}

class GetCustomerSuccessState extends GetCustomerState {
  final List<CustomerData> customerData;
  GetCustomerSuccessState(this.customerData);
}

class GetCustomerMoreLoadingState extends GetCustomerState {
  final List<CustomerData> customerData;
  GetCustomerMoreLoadingState(this.customerData);
}

class GetCustomerFailureState extends GetCustomerState {
  final ErrorResponseModel error;
  GetCustomerFailureState(this.error);
}
