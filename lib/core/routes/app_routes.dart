import 'package:flutter/material.dart';
import 'package:oss_frontend/features/auth/views/screens/register_screen.dart';

class AppRoutes {
  static const String registerScreen = '/register';
  static const String loginScreen = '/login';
  static const String createAdminScreen = '/createAdmin';
  static const String createBuyerScreen = '/createBuyer';
  static const String dashboardScreen = '/dashboard';
  static const String splashScreen = '/splash';
  // static const String

  static Map<String, WidgetBuilder> getRoutes() {
    return {registerScreen: (context) => const RegisterScreen()};
  }
}
