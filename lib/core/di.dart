import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> initDI() async {
  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Services
  final sp = SharedPrefsService();
  await sp.init();
  sl.registerSingleton<SharedPrefsService>(sp);

  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  // Data providers / APIs
  sl.registerLazySingleton<AuthApi>(() => AuthApi(client: sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(api: sl(), prefs: sl()),
  );
}
