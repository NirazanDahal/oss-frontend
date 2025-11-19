import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/di/injection.dart';
import 'package:oss_frontend/core/navigation/route_observer.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_bloc.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_bloc.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_remote_repository.dart';
import 'package:oss_frontend/features/auth/views/screens/login_screen.dart';
import 'package:oss_frontend/features/auth/views/screens/register_screen.dart';
import 'package:oss_frontend/features/costomer/blocs/add_customer/add_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/blocs/get_customer/get_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/repositories/add_customer_remote_repository.dart';
import 'package:oss_frontend/features/costomer/repositories/get_customer_remote_repository.dart';
import 'package:oss_frontend/features/costomer/views/screens/get_customer_screen.dart';
import 'package:oss_frontend/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:oss_frontend/features/profile/blocs/profile/profile_bloc.dart';
import 'package:oss_frontend/features/profile/repositories/profile_remote_repository.dart';
import 'package:oss_frontend/features/profile/views/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies(); // ← THIS LINE WAS MISSING!
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
        navigatorObservers: [appRouteObserver], // ← Global instance
        scaffoldMessengerKey: SnackUtils.messengerKey,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.loginScreen,

        // DELETE routes: AppRoutes.getRoutes()
        // REPLACE WITH THIS:
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.loginScreen:
              return MaterialPageRoute(builder: (_) => const LoginScreen());
            case AppRoutes.registerScreen:
              return MaterialPageRoute(builder: (_) => const RegisterScreen());
            case AppRoutes.dashBoardScreen:
              return MaterialPageRoute(builder: (_) => const DashboardScreen());
            case AppRoutes.getCustomerScreen:
              return MaterialPageRoute(
                builder: (_) => const GetCustomerScreen(),
              );
            case AppRoutes.profileScreen:
              return MaterialPageRoute(builder: (_) => const ProfileScreen());
            default:
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Center(child: Text('Page Not Found'))),
              );
          }
        },
      ),
    );
  }
}
