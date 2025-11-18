
import 'package:oss_frontend/features/auth/models/res/login_response.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<LoginResponse> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}