import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:oss_frontend/features/auth/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:oss_frontend/core/constants/api_constants.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_bloc.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_bloc.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_repository.dart';
import 'package:oss_frontend/features/auth/usecases/register_usecase.dart';
import 'package:oss_frontend/features/auth/usecases/login_usecase.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // AuthService
  locator.registerLazySingleton<AuthService>(() => AuthService(locator<SharedPreferences>()));

  // Dio
  final dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    contentType: 'application/json',
  ));

  // Add Authorization header interceptor
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = locator<AuthService>().token;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
  );

  locator.registerLazySingleton<Dio>(() => dio);

  // Repository
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository(locator<Dio>()));

  // Use cases
  locator.registerFactory<RegisterUseCase>(() => RegisterUseCase(locator<AuthRepository>()));
  locator.registerFactory<LoginUseCase>(() => LoginUseCase(locator<AuthRepository>()));

  // Blocs
  locator.registerFactory<RegisterBloc>(() => RegisterBloc(locator<RegisterUseCase>()));
  locator.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: locator<LoginUseCase>(),
      authService: locator<AuthService>(),
    ),
  );
}