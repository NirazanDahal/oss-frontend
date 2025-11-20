import 'package:get_it/get_it.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_remote_repository.dart';
import 'package:oss_frontend/features/auth/services/auth_api_service.dart';
import 'package:oss_frontend/features/costomer/repositories/add_customer_remote_repository.dart';
import 'package:oss_frontend/features/costomer/repositories/get_customer_remote_repository.dart';
import 'package:oss_frontend/features/costomer/repositories/update_customer_remote_repository.dart';
import 'package:oss_frontend/features/costomer/services/add_customer_api_service.dart';
import 'package:oss_frontend/features/costomer/services/get_customer_api_service.dart';
import 'package:oss_frontend/features/costomer/services/update_customer_api_service.dart';
import 'package:oss_frontend/features/profile/repositories/profile_remote_repository.dart';
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
  getIt.registerLazySingleton<ProfileApiService>(() => ProfileApiService());
  getIt.registerLazySingleton<AddCustomerApiService>(
    () => AddCustomerApiService(),
  );
  getIt.registerLazySingleton<GetCustomerApiService>(
    () => GetCustomerApiService(),
  );
  getIt.registerLazySingleton<UpdateCustomerApiService>(
    () => UpdateCustomerApiService(),
  );

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
  getIt.registerLazySingleton<ProfileRemoteRepository>(
    () => ProfileRemoteRepository(
      getIt<ProfileApiService>(),
      getIt<AuthLocalRepositoty>(),
    ),
  );
  getIt.registerLazySingleton<AddCustomerRemoteRepository>(
    () => AddCustomerRemoteRepository(
      getIt<AddCustomerApiService>(),
      getIt<AuthLocalRepositoty>(),
    ),
  );
  getIt.registerLazySingleton<GetCustomerRemoteRepository>(
    () => GetCustomerRemoteRepository(
      getIt<GetCustomerApiService>(),
      getIt<AuthLocalRepositoty>(),
    ),
  );
  getIt.registerLazySingleton<UpdateCustomerRemoteRepository>(
    () => UpdateCustomerRemoteRepository(
      getIt<UpdateCustomerApiService>(),
      getIt<AuthLocalRepositoty>(),
    ),
  );
}
