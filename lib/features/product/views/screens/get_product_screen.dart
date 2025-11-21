import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/costomer/views/widgets/empty_state.dart';
import 'package:oss_frontend/features/costomer/views/widgets/error_state.dart';
import 'package:oss_frontend/features/product/blocs/delete_product/delete_product_bloc.dart';
import 'package:oss_frontend/features/product/blocs/get_product/get_product_bloc.dart';
import 'package:oss_frontend/main.dart';
import '../widgets/product_card.dart';
import '../widgets/product_search_bar.dart';

class GetProductScreen extends StatefulWidget {
  const GetProductScreen({super.key});

  @override
  State<GetProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<GetProductScreen> with RouteAware {
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
      context.read<GetProductBloc>().add(GetProductSubmittedEvent());
      _loadedOnce = false;
    }
  }

  @override
  void didPopNext() {
    context.read<GetProductBloc>().add(GetProductSubmittedEvent());
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 600), () {
      context.read<GetProductBloc>().add(
            GetProductSubmittedEvent(search: query.trim()),
          );
    });
  }

  void _showDeleteConfirmation(String productId, String productName) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "$productName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context
                  .read<DeleteProductBloc>()
                  .add(DeleteProductSubmittedEvent(productId));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<GetProductBloc>().add(GetProductLoadMoreEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addProductScreen);
            },
            icon: const Icon(Icons.add_box),
            tooltip: "Add Product",
          ),
        ],
      ),
      body: Column(
        children: [
          ProductSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<GetProductBloc>().add(
                      GetProductSubmittedEvent(
                        search: _searchController.text.trim(),
                      ),
                    );
              },
              child: BlocListener<DeleteProductBloc, DeleteProductState>(
                listener: (context, deleteState) {
                  if (deleteState is DeleteProductSuccessState) {
                    SnackUtils.showSuccess(
                      context,
                      ResponseConstants.deleteProductSuccessMessage,
                    );
                    context.read<GetProductBloc>().add(
                          GetProductSubmittedEvent(
                            search: _searchController.text.trim(),
                          ),
                        );
                  }
                  if (deleteState is DeleteProductFailureState) {
                    SnackUtils.showError(context, deleteState.error.error);
                  }
                },
                child: BlocBuilder<GetProductBloc, GetProductState>(
                  builder: (context, state) {
                    if (state is GetProductLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }

                    if (state is GetProductFailureState) {
                      return ErrorState(
                        message: state.error.error,
                        onRetry: () => context.read<GetProductBloc>().add(
                              GetProductSubmittedEvent(),
                            ),
                      );
                    }

                    final products = state is GetProductSuccessState
                        ? state.productData
                        : (state is GetProductMoreLoadingState
                            ? state.productData
                            : <dynamic>[]);

                    if (products.isEmpty) {
                      return EmptyState(
                        message: _searchController.text.isEmpty
                            ? "No products yet"
                            : "No product found",
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: products.length +
                          (state is GetProductMoreLoadingState ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == products.length) {
                          return const Padding(
                            padding: EdgeInsets.all(24),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }

                        final product = products[index];
                        return ProductCard(
                          name: product.name,
                          batchNo: product.batchNo,
                          quantity: product.quantity,
                          purchasePrice: product.purchasePrice,
                          sellingPrice: product.sellingPrice,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.updateProductScreen,
                              arguments: product,
                            );
                          },
                          onDelete: () {
                            _showDeleteConfirmation(product.id, product.name);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
