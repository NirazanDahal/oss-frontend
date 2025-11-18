import 'package:get_it/get_it.dart';
import 'package:oss_frontend/features/auth/repositories/auth_repository.dart';
import 'package:oss_frontend/features/auth/services/auth_api_service.dart';
import '../utils/local_storage_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingletonAsync<LocalStorageService>(() async {
    final service = LocalStorageService();
    await service.init();
    return service;
  });

  await getIt.allReady();

  //API service
  getIt.registerLazySingleton<AuthApiService>(() => AuthApiService());

  //Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<AuthApiService>(), getIt<LocalStorageService>()),
  );
}
