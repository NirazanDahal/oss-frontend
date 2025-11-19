import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/di/injection.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_bloc.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_remote_repository.dart';

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
        BlocProvider(create: (context) => RegisterBloc(getIt<AuthRemoteRepository>())),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: SnackUtils.messengerKey,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.registerScreen,
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
