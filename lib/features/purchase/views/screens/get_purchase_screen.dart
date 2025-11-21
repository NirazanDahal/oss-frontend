import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';
import 'package:oss_frontend/features/costomer/views/widgets/empty_state.dart';
import 'package:oss_frontend/features/costomer/views/widgets/error_state.dart';
import 'package:oss_frontend/features/purchase/blocs/get_purchase/get_purchase_bloc.dart';
import 'package:oss_frontend/features/purchase/blocs/get_purchase/get_purchase_event.dart';
import 'package:oss_frontend/features/purchase/blocs/get_purchase/get_purchase_state.dart';
import 'package:oss_frontend/features/purchase/views/widgets/purchase_card.dart';
import 'package:oss_frontend/main.dart';

class GetPurchaseScreen extends StatefulWidget {
  const GetPurchaseScreen({super.key});

  @override
  State<GetPurchaseScreen> createState() => _GetPurchaseScreenState();
}

class _GetPurchaseScreenState extends State<GetPurchaseScreen> with RouteAware {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debounceTimer;
  bool _loadedOnce = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _debounceTimer?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didPush() {
    if (_loadedOnce) {
      context.read<GetPurchaseBloc>().add(GetPurchaseSubmittedEvent());
      _loadedOnce = false;
    }
  }

  @override
  void didPopNext() {
    context.read<GetPurchaseBloc>().add(GetPurchaseSubmittedEvent());
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 600), () {
      context.read<GetPurchaseBloc>().add(
        GetPurchaseSubmittedEvent(search: query.trim()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<GetPurchaseBloc>().add(GetPurchaseLoadMoreEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Purchases",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addPurchaseScreen);
            },
            icon: const Icon(Icons.add_box),
            tooltip: "Record Purchase",
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search purchases...',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                prefixIcon: Icon(Icons.search, color: AppColors.primary),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<GetPurchaseBloc>().add(
                  GetPurchaseSubmittedEvent(
                    search: _searchController.text.trim(),
                  ),
                );
              },
              child: BlocBuilder<GetPurchaseBloc, GetPurchaseState>(
                builder: (context, state) {
                  if (state is GetPurchaseLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  if (state is GetPurchaseFailureState) {
                    return ErrorState(
                      message: state.error.error,
                      onRetry: () => context.read<GetPurchaseBloc>().add(
                        GetPurchaseSubmittedEvent(),
                      ),
                    );
                  }

                  final purchases = state is GetPurchaseSuccessState
                      ? state.purchaseData
                      : (state is GetPurchaseMoreLoadingState
                            ? state.purchaseData
                            : <dynamic>[]);

                  if (purchases.isEmpty) {
                    return EmptyState(
                      message: _searchController.text.isEmpty
                          ? "No purchases yet"
                          : "No purchase found",
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        purchases.length +
                        (state is GetPurchaseMoreLoadingState ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == purchases.length) {
                        return const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }

                      final purchase = purchases[index];
                      return PurchaseCard(
                        vendorName: purchase.vendorName,
                        date: purchase.date,
                        address: purchase.address,
                        totalPrice: purchase.totalPrice,
                        productCount: purchase.products.length,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.purchaseDetailsScreen,
                            arguments: purchase,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
