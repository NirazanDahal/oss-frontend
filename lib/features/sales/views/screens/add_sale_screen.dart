import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/costomer/blocs/get_customer/get_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/blocs/get_customer/get_customer_event.dart';
import 'package:oss_frontend/features/costomer/blocs/get_customer/get_customer_state.dart';
import 'package:oss_frontend/features/costomer/models/res/add_customer_response_model.dart';
import 'package:oss_frontend/features/product/blocs/get_product/get_product_bloc.dart';
import 'package:oss_frontend/features/product/models/res/add_product_response_model.dart';
import 'package:oss_frontend/features/sales/blocs/add_sale/add_sale_bloc.dart';
import 'package:oss_frontend/features/sales/blocs/add_sale/add_sale_event.dart';
import 'package:oss_frontend/features/sales/blocs/add_sale/add_sale_state.dart';
import 'package:oss_frontend/features/sales/models/req/add_sale_request_model.dart';
import 'package:oss_frontend/features/sales/views/widgets/sale_product_card.dart';

class AddSaleScreen extends StatefulWidget {
  const AddSaleScreen({super.key});

  @override
  State<AddSaleScreen> createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen> {
  CustomerData? _selectedCustomer;
  final List<SaleProductInputData> _products = [];

  @override
  void initState() {
    super.initState();
    _addProduct(); // Start with one product
    // Load customers and products
    context.read<GetCustomerBloc>().add(GetCustomerSubmittedEvent());
    context.read<GetProductBloc>().add(GetProductSubmittedEvent());
  }

  @override
  void dispose() {
    for (var product in _products) {
      product.dispose();
    }
    super.dispose();
  }

  void _addProduct() {
    setState(() {
      _products.add(SaleProductInputData());
    });
  }

  void _removeProduct(int index) {
    if (_products.length > 1) {
      setState(() {
        _products[index].dispose();
        _products.removeAt(index);
      });
    } else {
      SnackUtils.showError(context, 'At least one product is required');
    }
  }

  double get _grandTotal {
    double total = 0;
    for (var product in _products) {
      final quantity = int.tryParse(product.quantityController.text) ?? 0;
      final sellingPrice = product.selectedProduct?.sellingPrice.toDouble() ?? 0;
      total += sellingPrice * quantity;
    }
    return total;
  }

  int get _totalPointsToEarn {
    // Assuming 2% of total as points (adjust as per your business logic)
    return (_grandTotal * 0.02).round();
  }

  void _showCustomerSelectionDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<GetCustomerBloc>(),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Text(
                          'Select Customer',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(dialogContext),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: BlocBuilder<GetCustomerBloc, GetCustomerState>(
                      builder: (context, state) {
                        if (state is GetCustomerLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is GetCustomerSuccessState) {
                          final customers = state.customerData;
                          if (customers.isEmpty) {
                            return const Center(
                              child: Text('No customers found'),
                            );
                          }
                          return ListView.builder(
                            itemCount: customers.length,
                            itemBuilder: (context, index) {
                              final customer = customers[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.primary.withOpacity(0.1),
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.primary,
                                  ),
                                ),
                                title: Text(
                                  customer.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  '${customer.phone} | Points: ${customer.points}',
                                ),
                                trailing: _selectedCustomer?.id == customer.id
                                    ? Icon(
                                        Icons.check_circle,
                                        color: AppColors.primary,
                                      )
                                    : null,
                                onTap: () {
                                  setState(() {
                                    _selectedCustomer = customer;
                                  });
                                  Navigator.pop(dialogContext);
                                },
                              );
                            },
                          );
                        }
                        return const Center(
                          child: Text('Failed to load customers'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showProductSelectionDialog(int productIndex) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<GetProductBloc>(),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Text(
                          'Select Product',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(dialogContext),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: BlocBuilder<GetProductBloc, GetProductState>(
                      builder: (context, state) {
                        if (state is GetProductLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is GetProductSuccessState) {
                          final products = state.productData;
                          if (products.isEmpty) {
                            return const Center(
                              child: Text('No products found'),
                            );
                          }
                          return ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              final isOutOfStock = product.quantity <= 0;
                              return ListTile(
                                enabled: !isOutOfStock,
                                leading: CircleAvatar(
                                  backgroundColor: isOutOfStock
                                      ? Colors.grey.shade300
                                      : AppColors.primary.withOpacity(0.1),
                                  child: Icon(
                                    Icons.inventory_2,
                                    color: isOutOfStock
                                        ? Colors.grey.shade600
                                        : AppColors.primary,
                                  ),
                                ),
                                title: Text(
                                  product.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isOutOfStock
                                        ? Colors.grey.shade600
                                        : Colors.black87,
                                  ),
                                ),
                                subtitle: Text(
                                  'Batch: ${product.batchNo} | Stock: ${product.quantity} | Rs. ${product.sellingPrice}',
                                  style: TextStyle(
                                    color: isOutOfStock
                                        ? Colors.grey.shade600
                                        : Colors.black54,
                                  ),
                                ),
                                trailing: isOutOfStock
                                    ? Chip(
                                        label: const Text(
                                          'Out of Stock',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        backgroundColor: Colors.red.shade100,
                                        labelPadding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                      )
                                    : (_products[productIndex].selectedProduct?.id ==
                                            product.id
                                        ? Icon(
                                            Icons.check_circle,
                                            color: AppColors.primary,
                                          )
                                        : null),
                                onTap: isOutOfStock
                                    ? null
                                    : () {
                                        setState(() {
                                          _products[productIndex].selectedProduct =
                                              product;
                                        });
                                        Navigator.pop(dialogContext);
                                      },
                              );
                            },
                          );
                        }
                        return const Center(
                          child: Text('Failed to load products'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitSale() {
    if (_selectedCustomer == null) {
      SnackUtils.showError(context, 'Please select a customer');
      return;
    }

    bool hasEmptyProduct = false;
    bool hasInvalidQuantity = false;

    for (var product in _products) {
      if (product.selectedProduct == null ||
          product.quantityController.text.trim().isEmpty) {
        hasEmptyProduct = true;
        break;
      }

      final quantity = int.tryParse(product.quantityController.text) ?? 0;
      if (quantity <= 0) {
        hasInvalidQuantity = true;
        break;
      }

      if (quantity > product.selectedProduct!.quantity) {
        SnackUtils.showError(
          context,
          'Quantity for ${product.selectedProduct!.name} exceeds available stock',
        );
        return;
      }
    }

    if (hasEmptyProduct) {
      SnackUtils.showError(context, 'Please select all products and quantities');
      return;
    }

    if (hasInvalidQuantity) {
      SnackUtils.showError(context, 'Please enter valid quantities');
      return;
    }

    final products = _products.map((p) {
      return SaleProductRequest(
        product: p.selectedProduct!.id,
        quantity: int.parse(p.quantityController.text.trim()),
      );
    }).toList();

    final request = AddSaleRequestModel(
      customerId: _selectedCustomer!.id,
      products: products,
    );

    context.read<AddSaleBloc>().add(AddSaleSubmittedEvent(request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Record Sale',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocListener<AddSaleBloc, AddSaleState>(
        listener: (context, state) {
          if (state is AddSaleSuccessState) {
            SnackUtils.showSuccess(context, state.response.message);
            // Show points earned dialog
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Row(
                  children: [
                    Icon(Icons.check_circle, color: AppColors.success, size: 28),
                    const SizedBox(width: 8),
                    const Text('Sale Recorded!'),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount: Rs. ${state.response.data.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Points Earned: ${state.response.pointsAdded}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Customer Total Points: ${state.response.customerPoints}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      context.read<AddSaleBloc>().add(ResetAddSaleStateEvent());
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
          if (state is AddSaleFailureState) {
            SnackUtils.showError(context, state.error.error);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Customer Selection Card
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: _showCustomerSelectionDialog,
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: _selectedCustomer == null
                                      ? Colors.grey.shade200
                                      : AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: _selectedCustomer == null
                                      ? Colors.grey.shade600
                                      : AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selectedCustomer == null
                                          ? 'Select Customer'
                                          : _selectedCustomer!.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: _selectedCustomer == null
                                            ? FontWeight.normal
                                            : FontWeight.bold,
                                        color: _selectedCustomer == null
                                            ? Colors.grey.shade600
                                            : Colors.black87,
                                      ),
                                    ),
                                    if (_selectedCustomer != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        '${_selectedCustomer!.phone} | Points: ${_selectedCustomer!.points}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Products Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Products',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _addProduct,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Product'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return SaleProductCard(
                          selectedProduct: product.selectedProduct,
                          quantityController: product.quantityController,
                          onRemove: () => _removeProduct(index),
                          onSelectProduct: () => _showProductSelectionDialog(index),
                          index: index,
                          onValueChanged: () {
                            setState(() {
                              // Trigger rebuild to update grand total
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Summary Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Grand Total:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Rs. ${_grandTotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Points to Earn:',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '$_totalPointsToEarn pts',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Submit Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: BlocBuilder<AddSaleBloc, AddSaleState>(
                builder: (context, state) {
                  final isLoading = state is AddSaleLoadingState;
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitSale,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Record Sale',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SaleProductInputData {
  ProductData? selectedProduct;
  final TextEditingController quantityController = TextEditingController();

  void dispose() {
    quantityController.dispose();
  }
}
