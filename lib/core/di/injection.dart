import 'package:get_it/get_it.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_remote_repository.dart';
import 'package:oss_frontend/features/auth/services/auth_api_service.dart';
import 'package:oss_frontend/features/profile/repositories/profile_repository.dart';
import 'package:oss_frontend/features/profile/services/profile_api_service.dart';
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
  getIt.registerLazySingleton<AuthLocalRepositoty>(
    () => AuthLocalRepositoty(getIt<LocalStorageService>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(
      getIt<AuthApiService>(),
      getIt<AuthLocalRepositoty>(),
    ),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(
      getIt<ProfileApiService>(),
      getIt<AuthLocalRepositoty>(),
    ),
  );
}
