import 'package:oss_frontend/features/customer/models/res/customer_response_model.dart';
import 'package:oss_frontend/features/customer/repositories/remote/customer_remote_repository.dart';

class GetCustomersUseCase {
  final CustomerRepository repository;

  GetCustomersUseCase(this.repository);

  Future<CustomerResponse> call({
    String? search,
    int page = 1,
    int limit = 10,
  }) {
    return repository.getCustomers(search: search, page: page, limit: limit);
  }
}