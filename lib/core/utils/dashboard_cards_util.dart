import 'package:flutter/material.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';

class DashboardCardsUtil {
  static const List<Map<String, dynamic>> dashboardItems = [
    {
      'name': 'Customer',
      'color': Colors.blue,
      'icon': Icons.person,
      'route': AppRoutes.getCustomerScreen,
    },
    {
      'name': 'Product',
      'color': Colors.yellow,
      'icon': Icons.shopping_bag,
      // 'route': AppRoutes.
    },
    {
      'name': 'Purchase',
      'color': Colors.green,
      'icon': Icons.shopping_cart,
      // 'route': AppRoutes.customerScreen,
    },
    {
      'name': 'Sales',
      'color': Colors.purple,
      'icon': Icons.sell,
      // 'route': AppRoutes.customerScreen,
    },
  ];
}
