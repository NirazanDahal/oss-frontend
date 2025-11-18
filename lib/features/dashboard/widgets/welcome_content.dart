// lib/features/dashboard/presentation/widgets/welcome_content.dart

import 'package:flutter/material.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard,
            size: 100,
            color: AppColors.primary.withOpacity(0.6),
          ),
          const SizedBox(height: 24),
          Text(
            'Welcome to OSS Admin Panel',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'You are successfully logged in',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}