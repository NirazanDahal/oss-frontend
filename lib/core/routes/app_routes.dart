import 'package:flutter/material.dart';
import 'package:oss_frontend/features/auth/views/screens/login_screen.dart';
import 'package:oss_frontend/features/auth/views/screens/register_screen.dart';
import 'package:oss_frontend/features/costomer/views/screens/get_customer_screen.dart';
import 'package:oss_frontend/features/costomer/views/widgets/add_customer_widget.dart';
import 'package:oss_frontend/features/costomer/views/widgets/update_customer_widget.dart';
import 'package:oss_frontend/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:oss_frontend/features/product/models/res/add_product_response_model.dart';
import 'package:oss_frontend/features/product/views/screens/add_product_screen.dart';
import 'package:oss_frontend/features/product/views/screens/get_product_screen.dart';
import 'package:oss_frontend/features/product/views/widgets/update_product_widget.dart';
import 'package:oss_frontend/features/purchase/views/screens/add_purchase_screen.dart';
import 'package:oss_frontend/features/purchase/views/screens/get_purchase_screen.dart';
import 'package:oss_frontend/features/profile/views/screens/profile_screen.dart';
import 'package:oss_frontend/features/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash';
  static const String registerScreen = '/register';
  static const String loginScreen = '/login';
  static const String profileScreen = '/profile';
  static const String getCustomerScreen = '/getCustomer';
  static const String addCustomer = '/addCustomer';
  static const String updateCustomer = '/updateCustomer';
  static const String dashBoardScreen = '/dashboard';
  static const String getProductScreen = '/getProduct';
  static const String addProductScreen = '/addProduct';
  static const String updateProductScreen = '/updateProduct';
  static const String addPurchaseScreen = '/addPurchase';
  static const String getPurchaseScreen = '/getPurchase';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashScreen: (context) => const SplashScreen(),
      registerScreen: (context) => const RegisterScreen(),
      loginScreen: (context) => const LoginScreen(),
      profileScreen: (context) => const ProfileScreen(),
      getCustomerScreen: (context) => const GetCustomerScreen(),
      addCustomer: (context) => const AddCustomerWidget(),
      dashBoardScreen: (context) => const DashboardScreen(),
      getProductScreen: (context) => const GetProductScreen(),
      addProductScreen: (context) => const AddProductScreen(),
      addPurchaseScreen: (context) => const AddPurchaseScreen(),
      getPurchaseScreen: (context) => const GetPurchaseScreen(),
    };
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case updateCustomer:
        final customer = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => UpdateCustomerWidget(customer: customer),
        );
      case updateProductScreen:
        final product = settings.arguments as ProductData;
        return MaterialPageRoute(
          builder: (_) => UpdateProductWidget(product: product),
        );
    }
    return null;
  }
}
