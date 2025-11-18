
import 'package:flutter/material.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/di/injection.dart' as di;
import 'package:oss_frontend/features/auth/pages/login_page.dart';
import 'package:oss_frontend/features/auth/services/auth_service.dart';
import 'package:oss_frontend/features/dashboard/widgets/bottom_profile_bar.dart';
import 'package:oss_frontend/features/dashboard/widgets/feature_grid.dart';
import 'package:oss_frontend/features/dashboard/widgets/profile_dialog.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = di.locator<AuthService>();

    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          Column(
            children: [
              // Top App Bar
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 16, 24, 24),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: const Text(
                  'OSS Admin Panel',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              // Feature Grid
               Expanded(child: FeatureGrid()),
            ],
          ),

          // Bottom Profile Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomProfileBar(
              onLogout: () async {
                await authService.logout();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                }
              },
              onProfileTap: (state) => ProfileDialog.show(context, state),
            ),
          ),
        ],
      ),
    );
  }
}