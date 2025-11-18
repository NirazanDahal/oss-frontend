
import 'package:oss_frontend/features/auth/models/res/register_response.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<RegisterResponse> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
    );
  }
}