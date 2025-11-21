import 'package:flutter/material.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';

class DashboardCardsUtil {
  static final List<Map<String, dynamic>> dashboardItems = [
    {
      'name': 'Customers',
      'icon': Icons.people_outline,
      'color': AppColors.cardBlue,
      'route': AppRoutes.getCustomerScreen,
    },
    {
      'name': 'Products',
      'icon': Icons.inventory_2_outlined,
      'color': AppColors.cardGreen,
      'route': AppRoutes.getProductScreen,
    },
    {
      'name': 'Purchases',
      'icon': Icons.shopping_cart_outlined,
      'color': AppColors.cardOrange,
      // 'route': AppRoutes.purchaseScreen,
    },
    {
      'name': 'Sales',
      'icon': Icons.trending_up,
      'color': AppColors.cardPurple,
      // 'route': AppRoutes.salesScreen,
    },
    {
      'name': 'Reports',
      'icon': Icons.bar_chart,
      'color': AppColors.cardTeal,
      // 'route': AppRoutes.reportsScreen,
    },
    {
      'name': 'Settings',
      'icon': Icons.settings_outlined,
      'color': AppColors.cardRed,
      // 'route': AppRoutes.settingsScreen,
    },
  ];
}
