import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/product/blocs/update_product/update_product_bloc.dart';
import 'package:oss_frontend/features/product/models/res/add_product_response_model.dart';
import '../widgets/product_text_field.dart';

class UpdateProductWidget extends StatefulWidget {
  final ProductData product;

  const UpdateProductWidget({super.key, required this.product});

  @override
  State<UpdateProductWidget> createState() => _UpdateProductWidgetState();
}

class _UpdateProductWidgetState extends State<UpdateProductWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _batchNoController;
  late final TextEditingController _quantityController;
  late final TextEditingController _purchasePriceController;
  late final TextEditingController _sellingPriceController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _batchNoController = TextEditingController(text: widget.product.batchNo);
    _quantityController =
        TextEditingController(text: widget.product.quantity.toString());
    _purchasePriceController =
        TextEditingController(text: widget.product.purchasePrice.toString());
    _sellingPriceController =
        TextEditingController(text: widget.product.sellingPrice.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _batchNoController.dispose();
    _quantityController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Update Product",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ProductTextField(
                        controller: _nameController,
                        label: "Product Name",
                        icon: Icons.inventory_2_outlined,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 16),
                      ProductTextField(
                        controller: _batchNoController,
                        label: "Batch Number",
                        icon: Icons.qr_code,
                        textCapitalization: TextCapitalization.characters,
                      ),
                      const SizedBox(height: 16),
                      ProductTextField(
                        controller: _quantityController,
                        label: "Quantity",
                        icon: Icons.inventory,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 16),
                      ProductTextField(
                        controller: _purchasePriceController,
                        label: "Purchase Price",
                        icon: Icons.shopping_cart,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 16),
                      ProductTextField(
                        controller: _sellingPriceController,
                        label: "Selling Price",
                        icon: Icons.sell,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),

            // Submit Button
            BlocConsumer<UpdateProductBloc, UpdateProductState>(
              listener: (context, state) {
                if (state is UpdateProductSuccessState) {
                  SnackUtils.showSuccess(
                    context,
                    ResponseConstants.updateProductSuccessMessage,
                  );
                  Navigator.pop(context);
                }
                if (state is UpdateProductFailureState) {
                  SnackUtils.showError(context, state.error.error);
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: state is UpdateProductLoadingState
                        ? null
                        : () {
                            if (_nameController.text.isNotEmpty &&
                                _batchNoController.text.isNotEmpty &&
                                _quantityController.text.isNotEmpty &&
                                _purchasePriceController.text.isNotEmpty &&
                                _sellingPriceController.text.isNotEmpty) {
                              context.read<UpdateProductBloc>().add(
                                    UpdateProductSubmittedEvent(
                                      productId: widget.product.id,
                                      name: _nameController.text.trim(),
                                      batchNo: _batchNoController.text.trim(),
                                      quantity: _quantityController.text.trim(),
                                      purchasePrice:
                                          _purchasePriceController.text.trim(),
                                      sellingPrice:
                                          _sellingPriceController.text.trim(),
                                    ),
                                  );
                            } else {
                              SnackUtils.showError(
                                context,
                                ResponseConstants
                                    .updateProductValidationErrorMessage,
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: state is UpdateProductLoadingState
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Update Product",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
