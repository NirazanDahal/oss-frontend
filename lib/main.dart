import 'package:flutter/material.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/features/auth/pages/login_page.dart';
import 'package:oss_frontend/features/auth/pages/register_page.dart';
import 'package:oss_frontend/features/auth/services/auth_service.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = locator<AuthService>();

    return MaterialApp(
      title: 'Admin Panel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: authService.isLoggedIn ? const DashboardPage() : const LoginPage(),
      routes: {
        '/login': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/dashboard': (_) => const DashboardPage(),
      },
    );
  }
}

// Placeholder for now
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), backgroundColor: AppColors.primary, foregroundColor: Colors.white),
      body: const Center(child: Text('Welcome to Admin Dashboard!')),
    );
  }
}