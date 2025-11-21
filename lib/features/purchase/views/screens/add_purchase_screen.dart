import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/purchase/blocs/add_purchase/add_purchase_bloc.dart';
import 'package:oss_frontend/features/purchase/blocs/add_purchase/add_purchase_event.dart';
import 'package:oss_frontend/features/purchase/blocs/add_purchase/add_purchase_state.dart';
import 'package:oss_frontend/features/purchase/models/req/add_purchase_request_model.dart';
import 'package:oss_frontend/features/purchase/views/widgets/purchase_product_card.dart';

class AddPurchaseScreen extends StatefulWidget {
  const AddPurchaseScreen({super.key});

  @override
  State<AddPurchaseScreen> createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends State<AddPurchaseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vendorNameController = TextEditingController();
  final _addressController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  final List<ProductInputData> _products = [];

  @override
  void initState() {
    super.initState();
    _addProduct(); // Start with one product
  }

  @override
  void dispose() {
    _vendorNameController.dispose();
    _addressController.dispose();
    for (var product in _products) {
      product.dispose();
    }
    super.dispose();
  }

  void _addProduct() {
    setState(() {
      _products.add(ProductInputData());
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
      final rate = double.tryParse(product.rateController.text) ?? 0;
      final quantity = int.tryParse(product.quantityController.text) ?? 0;
      total += rate * quantity;
    }
    return total;
  }

  void _submitPurchase() {
    if (_vendorNameController.text.trim().isEmpty) {
      SnackUtils.showError(context, 'Please enter vendor name');
      return;
    }

    if (_addressController.text.trim().isEmpty) {
      SnackUtils.showError(context, 'Please enter address');
      return;
    }

    bool hasEmptyProduct = false;
    for (var product in _products) {
      if (product.nameController.text.trim().isEmpty ||
          product.rateController.text.trim().isEmpty ||
          product.quantityController.text.trim().isEmpty) {
        hasEmptyProduct = true;
        break;
      }
    }

    if (hasEmptyProduct) {
      SnackUtils.showError(context, 'Please fill all product fields');
      return;
    }

    final products = _products.map((p) {
      return PurchaseProductRequest(
        productName: p.nameController.text.trim(),
        rate: double.parse(p.rateController.text.trim()),
        quantity: int.parse(p.quantityController.text.trim()),
      );
    }).toList();

    final request = AddPurchaseRequestModel(
      vendorName: _vendorNameController.text.trim(),
      date: _selectedDate.toIso8601String().split('T')[0],
      address: _addressController.text.trim(),
      products: products,
    );

    context.read<AddPurchaseBloc>().add(AddPurchaseSubmittedEvent(request));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Record Purchase',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocListener<AddPurchaseBloc, AddPurchaseState>(
        listener: (context, state) {
          if (state is AddPurchaseSuccessState) {
            SnackUtils.showSuccess(context, state.response.message);
            context.read<AddPurchaseBloc>().add(ResetAddPurchaseStateEvent());
            Navigator.pop(context);
          }
          if (state is AddPurchaseFailureState) {
            SnackUtils.showError(context, state.error.error);
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Vendor Details Card
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Vendor Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: _vendorNameController,
                                decoration: InputDecoration(
                                  labelText: 'Vendor Name',
                                  hintText: 'Enter vendor name',
                                  prefixIcon: const Icon(Icons.business),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              InkWell(
                                onTap: () => _selectDate(context),
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: 'Purchase Date',
                                    prefixIcon: const Icon(
                                      Icons.calendar_today,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: _addressController,
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                  hintText: 'Enter vendor address',
                                  prefixIcon: const Icon(Icons.location_on),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                maxLines: 2,
                              ),
                            ],
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
                          return PurchaseProductCard(
                            nameController: product.nameController,
                            rateController: product.rateController,
                            quantityController: product.quantityController,
                            onRemove: () => _removeProduct(index),
                            index: index,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      // Grand Total
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Grand Total:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                child: BlocBuilder<AddPurchaseBloc, AddPurchaseState>(
                  builder: (context, state) {
                    final isLoading = state is AddPurchaseLoadingState;
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submitPurchase,
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
                                'Record Purchase',
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
      ),
    );
  }
}

class ProductInputData {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void dispose() {
    nameController.dispose();
    rateController.dispose();
    quantityController.dispose();
  }
}
