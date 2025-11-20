import 'package:oss_frontend/features/costomer/models/res/add_customer_response_model.dart';

class UpdateCustomerResponseModel {
  final bool success;
  final CustomerData customerData;

  UpdateCustomerResponseModel({
    required this.success,
    required this.customerData,
  });

  factory UpdateCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateCustomerResponseModel(
      success: json['success'] ?? false,
      customerData: json['data'],
    );
  }
}
