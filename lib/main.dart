import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/di/injection.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_bloc.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_bloc.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_remote_repository.dart';
import 'package:oss_frontend/features/costomer/blocs/add_customer/add_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/blocs/get_customer/get_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/repositories/add_customer_remote_repository.dart';
import 'package:oss_frontend/features/costomer/repositories/get_customer_remote_repository.dart';
import 'package:oss_frontend/features/profile/blocs/profile/profile_bloc.dart';
import 'package:oss_frontend/features/profile/repositories/profile_remote_repository.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterBloc(getIt<AuthRemoteRepository>()),
        ),
        BlocProvider(create: (_) => LoginBloc(getIt<AuthRemoteRepository>())),
        BlocProvider(
          create: (_) => ProfileBloc(getIt<ProfileRemoteRepository>()),
        ),
        BlocProvider(
          create: (_) => AddCustomerBloc(getIt<AddCustomerRemoteRepository>()),
        ),
        BlocProvider(
          create: (_) => GetCustomerBloc(getIt<GetCustomerRemoteRepository>()),
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: SnackUtils.messengerKey,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        initialRoute: AppRoutes.loginScreen,
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
