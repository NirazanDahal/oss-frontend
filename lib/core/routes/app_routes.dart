import 'package:flutter/material.dart';
import 'package:oss_frontend/features/auth/views/screens/login_screen.dart';
import 'package:oss_frontend/features/auth/views/screens/register_screen.dart';
import 'package:oss_frontend/features/costomer/views/screens/add_customer_screen.dart';
import 'package:oss_frontend/features/profile/views/screens/profile_screen.dart';

class AppRoutes {
  static const String registerScreen = '/register';
  static const String loginScreen = '/login';
  static const String profileScreen = '/profile';
  static const String addCustomerScreen = '/addCustomer';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      registerScreen: (context) => const RegisterScreen(),
      loginScreen: (context) => const LoginScreen(),
      profileScreen: (context) => const ProfileScreen(),
      addCustomerScreen: (context) => const AddCustomerScreen(),
    };
  }
}
