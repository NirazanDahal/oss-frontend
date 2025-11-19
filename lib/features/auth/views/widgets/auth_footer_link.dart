import 'package:flutter/material.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';

class AuthFooterLink extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;

  const AuthFooterLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: AppColors.textSecondary),
          children: [
            TextSpan(text: text),
            TextSpan(
              text: " $linkText",
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
