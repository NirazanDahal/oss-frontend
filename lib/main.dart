import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/di/injection.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_bloc.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_bloc.dart';
import 'package:oss_frontend/features/auth/repositories/local/auth_local_repositoty.dart';
import 'package:oss_frontend/features/auth/repositories/remote/auth_remote_repository.dart';
import 'package:oss_frontend/features/costomer/blocs/add_customer/add_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/blocs/get_customer/get_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/blocs/update_customer/update_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/repositories/add_customer_remote_repository.dart';
import 'package:oss_frontend/features/costomer/repositories/get_customer_remote_repository.dart';
import 'package:oss_frontend/features/costomer/repositories/update_customer_remote_repository.dart';
import 'package:oss_frontend/features/product/blocs/add_product/add_product_bloc.dart';
import 'package:oss_frontend/features/product/blocs/delete_product/delete_product_bloc.dart';
import 'package:oss_frontend/features/product/blocs/get_product/get_product_bloc.dart';
import 'package:oss_frontend/features/product/blocs/update_product/update_product_bloc.dart';
import 'package:oss_frontend/features/product/repositories/add_product_remote_repository.dart';
import 'package:oss_frontend/features/product/repositories/delete_product_remote_repository.dart';
import 'package:oss_frontend/features/product/repositories/get_product_remote_repository.dart';
import 'package:oss_frontend/features/product/repositories/update_product_remote_repository.dart';
import 'package:oss_frontend/features/purchase/blocs/add_purchase/add_purchase_bloc.dart';
import 'package:oss_frontend/features/purchase/repositories/add_purchase_remote_repository.dart';
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
        BlocProvider(
          create: (_) => LoginBloc(
            getIt<AuthRemoteRepository>(),
            getIt<AuthLocalRepositoty>(),
          ),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(getIt<ProfileRemoteRepository>()),
        ),
        BlocProvider(
          create: (_) => AddCustomerBloc(getIt<AddCustomerRemoteRepository>()),
        ),
        BlocProvider(
          create: (_) => GetCustomerBloc(getIt<GetCustomerRemoteRepository>()),
        ),
        BlocProvider(
          create: (_) =>
              UpdateCustomerBloc(getIt<UpdateCustomerRemoteRepository>()),
        ),
        BlocProvider(
          create: (_) => AddProductBloc(getIt<AddProductRemoteRepository>()),
        ),
        BlocProvider(
          create: (_) => GetProductBloc(getIt<GetProductRemoteRepository>()),
        ),
        BlocProvider(
          create: (_) =>
              UpdateProductBloc(getIt<UpdateProductRemoteRepository>()),
        ),
        BlocProvider(
          create: (_) =>
              DeleteProductBloc(getIt<DeleteProductRemoteRepository>()),
        ),
        BlocProvider(
          create: (_) => AddPurchaseBloc(getIt<AddPurchaseRemoteRepository>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        initialRoute: AppRoutes.splashScreen,
        routes: AppRoutes.getRoutes(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
