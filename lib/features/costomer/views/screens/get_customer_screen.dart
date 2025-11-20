import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';
import 'package:oss_frontend/features/costomer/blocs/get_customer/get_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/blocs/get_customer/get_customer_event.dart';
import 'package:oss_frontend/features/costomer/blocs/get_customer/get_customer_state.dart';
import 'package:oss_frontend/features/costomer/views/widgets/add_customer_widget.dart';
import 'package:oss_frontend/main.dart';
import '../widgets/customer_search_bar.dart';
import '../widgets/customer_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/error_state.dart';

class GetCustomerScreen extends StatefulWidget {
  const GetCustomerScreen({super.key});

  @override
  State<GetCustomerScreen> createState() => _GetCustomerScreenState();
}

class _GetCustomerScreenState extends State<GetCustomerScreen> with RouteAware {
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

  // Screen opened for first time
  @override
  void didPush() {
    if (_loadedOnce) {
      log('screen opened for the first time');
      context.read<GetCustomerBloc>().add(GetCustomerSubmittedEvent());
      _loadedOnce = false;
    }
  }

  // Screen becomes visible again after navigating back
  @override
  void didPopNext() {
    context.read<GetCustomerBloc>().add(GetCustomerSubmittedEvent());
  }

  // Screen goes out of focus (not required, but optional)
  @override
  void didPushNext() {
    log("GetCustomerScreen hidden");
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 600), () {
      context.read<GetCustomerBloc>().add(
        GetCustomerSubmittedEvent(search: query.trim()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<GetCustomerBloc>().add(GetCustomerLoadMoreEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Customers",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addCustomer);
            },
            icon: const Icon(Icons.person_add),
            tooltip: "Add Customer",
          ),
        ],
      ),
      body: Column(
        children: [
          CustomerSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<GetCustomerBloc>().add(
                  GetCustomerSubmittedEvent(
                    search: _searchController.text.trim(),
                  ),
                );
              },
              child: BlocBuilder<GetCustomerBloc, GetCustomerState>(
                builder: (context, state) {
                  if (state is GetCustomerLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  if (state is GetCustomerFailureState) {
                    return ErrorState(
                      message: state.error.error,
                      onRetry: () => context.read<GetCustomerBloc>().add(
                        GetCustomerSubmittedEvent(),
                      ),
                    );
                  }

                  final customers = state is GetCustomerSuccessState
                      ? state.customerData
                      : (state is GetCustomerMoreLoadingState
                            ? state.customerData
                            : <dynamic>[]);

                  if (customers.isEmpty) {
                    return EmptyState(
                      message: _searchController.text.isEmpty
                          ? "No customers yet"
                          : "No customer found",
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        customers.length +
                        (state is GetCustomerMoreLoadingState ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == customers.length) {
                        return const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }

                      final c = customers[index];
                      return CustomerCard(
                        name: c.name,
                        phone: c.phone,
                        address: c.address,
                        points: c.points,
                        voidCallback: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.updateCustomer,
                            arguments: c,
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

  void _showAddCustomerDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const AddCustomerWidget(),
        ),
      ),
    );
  }
}
