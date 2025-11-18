// lib/features/customer/presentation/pages/customer_list_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/di/injection.dart' as di;
import 'package:oss_frontend/features/customer/bloc/customer/customer_bloc.dart';
import 'package:oss_frontend/features/dashboard/widgets/add_customer_dialog.dart';
import 'package:oss_frontend/features/dashboard/widgets/customer_card.dart';

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({super.key});

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      final state = context.read<CustomerBloc>().state;
      if (state is CustomerLoaded && !state.hasReachedMax) {
        context.read<CustomerBloc>().add(
              LoadCustomers(page: state.currentPage + 1, limit: 10),
            );
      }
    }
  }

  void _onSearchChanged(String query) {
    if (_currentQuery == query.trim()) return;
    _currentQuery = query.trim();

    // Debounce: wait 600ms before searching
    Future.delayed(const Duration(milliseconds: 600), () {
      if (_currentQuery == query.trim() && mounted) {
        if (_currentQuery.isEmpty) {
          context.read<CustomerBloc>().add( LoadCustomers(page: 1, limit: 10));
        } else {
          context.read<CustomerBloc>().add(SearchCustomers(_currentQuery, limit: 10));
        }
      }
    });
  }

  Future<void> _onRefresh() async {
    if (_currentQuery.isEmpty) {
      context.read<CustomerBloc>().add( LoadCustomers(page: 1, limit: 10));
    } else {
      context.read<CustomerBloc>().add(SearchCustomers(_currentQuery, limit: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.locator<CustomerBloc>()..add( LoadCustomers()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Customers'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.person_add),
              tooltip: 'Add Customer',
              onPressed: () => AddCustomerDialog.show(context),
            ),
          ],
        ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name or phone...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _currentQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _currentQuery = '';
                            context.read<CustomerBloc>().add( LoadCustomers(page: 1, limit: 10));
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onSubmitted: _onSearchChanged,
              ),
            ),

            // Customer Grid
            Expanded(
              child: BlocBuilder<CustomerBloc, CustomerState>(
                builder: (context, state) {
                  if (state is CustomerLoading && state is! CustomerLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is CustomerError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 64, color: AppColors.error),
                          const SizedBox(height: 16),
                          Text(state.message, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _onRefresh,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is CustomerLoaded) {
                    if (state.customers.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _currentQuery.isEmpty ? Icons.no_accounts : Icons.search_off,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _currentQuery.isEmpty
                                  ? 'No customers yet\nTap + to add one'
                                  : 'No customer found for "$_currentQuery"',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: GridView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: state.customers.length + (state.hasReachedMax ? 0 : 1),
                        itemBuilder: (context, index) {
                          if (index >= state.customers.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return CustomerCard(customer: state.customers[index]);
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}