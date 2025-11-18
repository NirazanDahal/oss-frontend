import 'package:oss_frontend/features/auth/models/res/profile_response.dart';
import '../repositories/remote/auth_repository.dart';

class GetProfileUseCase {
  final AuthRepository repository;

  GetProfileUseCase(this.repository);

  Future<ProfileResponse> call() {
    return repository.getProfile();
  }
}