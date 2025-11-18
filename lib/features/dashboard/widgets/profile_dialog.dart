// lib/features/dashboard/presentation/widgets/profile_dialog.dart

import 'package:flutter/material.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/features/auth/blocs/profile/profile_state.dart';

class ProfileDialog {
  static void show(BuildContext context, ProfileState state) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primary,
              child: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(
                  'https://ui-avatars.com/api/?background=2563EB&color=fff&bold=true&name=${state is ProfileLoaded ? state.user.name : 'Admin'}',
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: state is ProfileLoaded
            ? _buildProfileContent(state)
            : const SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  static Widget _buildProfileContent(ProfileLoaded state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow('Name', state.user.name),
        _infoRow('Email', state.user.email),
        _infoRow('Role', state.user.role.toUpperCase()),
        _infoRow('Member Since', _formatDate(state.user.createdAt)),
        const Divider(height: 32),
        Text(
          'User ID: ${state.user.id}',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  static Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}