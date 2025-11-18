import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/di/injection.dart' as di;
import 'package:oss_frontend/features/auth/blocs/profile/profile_bloc.dart';
import 'package:oss_frontend/features/auth/blocs/profile/profile_event.dart';
import 'package:oss_frontend/features/auth/blocs/profile/profile_state.dart';

class BottomProfileBar extends StatelessWidget {
  final VoidCallback onLogout;
  final Function(ProfileState) onProfileTap;

  const BottomProfileBar({
    super.key,
    required this.onLogout,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: BlocProvider(
          create: (_) => di.locator<ProfileBloc>()..add(LoadProfile()),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final name = state is ProfileLoaded ? state.user.name : 'Admin';
              final email = state is ProfileLoaded ? state.user.email : 'admin@example.com';

              return Row(
                children: [
                  // Profile Avatar
                  GestureDetector(
                    onTap: () => onProfileTap(state),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.primary,
                      child: CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage(
                          'https://ui-avatars.com/api/?background=2563EB&color=fff&bold=true&name=$name',
                        ),
                        child: state is ProfileLoading
                            ? const CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          email,
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        ),
                      ],
                    ),
                  ),

                  // Logout Button
                  OutlinedButton.icon(
                    onPressed: onLogout,
                    icon: const Icon(Icons.logout, size: 18),
                    label: const Text('Logout'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}