
import 'package:oss_frontend/features/customer/models/res/customer_response_model.dart';
import 'package:oss_frontend/features/customer/repositories/remote/customer_remote_repository.dart';

class CreateCustomerUseCase {
  final CustomerRepository repository;

  CreateCustomerUseCase(this.repository);

  Future<CustomerResponse> call({
    required String name,
    required String phone,
    required String address,
  }) {
    return repository.createCustomer(name: name, phone: phone, address: address);
  }
}