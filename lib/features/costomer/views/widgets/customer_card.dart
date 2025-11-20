import 'package:flutter/material.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';

class CustomerCard extends StatelessWidget {
  final String name;
  final String phone;
  final String address;
  final int points;
  final VoidCallback voidCallback;

  const CustomerCard({
    super.key,
    required this.name,
    required this.phone,
    required this.address,
    required this.points,
    required this.voidCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: voidCallback,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          radius: 26,
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : "?",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Icon(Icons.phone, size: 15, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(phone, style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(width: 16),
              Icon(Icons.location_on, size: 15, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  address,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.successBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "$points pts",
            style: TextStyle(
              color: AppColors.success,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
