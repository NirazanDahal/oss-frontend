// lib/features/dashboard/presentation/widgets/feature_grid.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/di/injection.dart' as di;
import 'package:oss_frontend/features/customer/bloc/customer/customer_bloc.dart';
import 'package:oss_frontend/features/dashboard/widgets/customer_list.dart';

class FeatureGrid extends StatelessWidget {
   const FeatureGrid({super.key});

  final List<Map<String, dynamic>> features = const [
    {
      'title': 'Customers',
      'icon': Icons.people,
      'color': AppColors.primary,
      'page': CustomerListPage(),
    },
    {
      'title': 'Products',
      'icon': Icons.inventory_2,
      'color': Color(0xFF10B981),
      'page': null,
    },
    {
      'title': 'Purchase',
      'icon': Icons.shopping_cart,
      'color': Color(0xFFF59E0B),
      'page': null,
    },
    {
      'title': 'Sales',
      'icon': Icons.point_of_sale,
      'color': Color(0xFF8B5CF6),
      'page': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 4 : 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        final page = feature['page'] as Widget?;

        return InkWell(
          onTap: page != null
              ? () {
                  if (feature['title'] == 'Customers') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => di.locator<CustomerBloc>()..add( LoadCustomers()),
                          child: page,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${feature['title']} - Coming Soon')),
                    );
                  }
                }
              : null,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [feature['color'], (feature['color'] as Color).withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: (feature['color'] as Color).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Opacity(
              opacity: page != null ? 1.0 : 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(feature['icon'], size: 56, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    feature['title'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  if (page == null)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('Coming Soon', style: TextStyle(fontSize: 12, color: Colors.white70)),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}