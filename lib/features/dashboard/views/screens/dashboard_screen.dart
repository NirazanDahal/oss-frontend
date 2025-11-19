import 'package:flutter/material.dart';
import 'package:oss_frontend/core/utils/dashboard_cards_util.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: isMobile ? 1 : 1.2,
            ),
            itemCount: DashboardCardsUtil.dashboardItems.length,
            itemBuilder: (context, index) {
              final item = DashboardCardsUtil.dashboardItems[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, item['route']);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: item['color'],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item['icon'],
                        size: isMobile ? 36 : 48, // Responsive icon size
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 16 : 20, // Responsive font
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
