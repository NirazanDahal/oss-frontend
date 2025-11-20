import 'package:flutter/material.dart';
import 'package:oss_frontend/features/auth/views/screens/login_screen.dart';
import 'package:oss_frontend/features/auth/views/screens/register_screen.dart';
import 'package:oss_frontend/features/costomer/views/screens/get_customer_screen.dart';
import 'package:oss_frontend/features/costomer/views/widgets/add_customer_widget.dart';
import 'package:oss_frontend/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:oss_frontend/features/profile/views/screens/profile_screen.dart';

class AppRoutes {
  static const String registerScreen = '/register';
  static const String loginScreen = '/login';
  static const String profileScreen = '/profile';
  static const String getCustomerScreen = '/getCustomer';
  static const String addCustomer = '/addCustomer';
  static const String dashBoardScreen = '/dashboard';

  static String getRouteName(String routeName) {
    return routeName;
  }

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      registerScreen: (context) => const RegisterScreen(),
      loginScreen: (context) => const LoginScreen(),
      profileScreen: (context) => const ProfileScreen(),
      getCustomerScreen: (context) => const GetCustomerScreen(),
      addCustomer: (context) => const AddCustomerWidget(),
      dashBoardScreen: (context) => const DashboardScreen(),
    };
  }
}
