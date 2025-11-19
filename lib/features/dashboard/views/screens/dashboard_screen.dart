import 'package:flutter/material.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/utils/dashboard_cards_util.dart';
import 'package:oss_frontend/features/dashboard/views/widgets/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          final crossAxisCount = isMobile
              ? 2
              : (constraints.maxWidth > 1200 ? 6 : 4);

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: isMobile ? 1.1 : 1.3,
            ),
            itemCount: DashboardCardsUtil.dashboardItems.length,
            itemBuilder: (context, index) {
              final item = DashboardCardsUtil.dashboardItems[index];
              return DashboardCard(
                title: item['name'],
                icon: item['icon'],
                color: item['color'],
                onTap: () {
                  final route = item['route'] as String?;
                  if (route != null && route.isNotEmpty) {
                    Navigator.pushNamed(context, route);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${item['name']} - Coming Soon")),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
