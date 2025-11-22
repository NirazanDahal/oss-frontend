import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/features/product/models/res/add_product_response_model.dart';

class SaleProductCard extends StatefulWidget {
  final ProductData? selectedProduct;
  final TextEditingController quantityController;
  final VoidCallback onRemove;
  final VoidCallback onSelectProduct;
  final int index;
  final VoidCallback? onValueChanged;

  const SaleProductCard({
    super.key,
    required this.selectedProduct,
    required this.quantityController,
    required this.onRemove,
    required this.onSelectProduct,
    required this.index,
    this.onValueChanged,
  });

  @override
  State<SaleProductCard> createState() => _SaleProductCardState();
}

class _SaleProductCardState extends State<SaleProductCard> {
  double _lineTotal = 0.0;

  @override
  void initState() {
    super.initState();
    widget.quantityController.addListener(_updateLineTotal);
    _updateLineTotal();
  }

  @override
  void dispose() {
    widget.quantityController.removeListener(_updateLineTotal);
    super.dispose();
  }

  @override
  void didUpdateWidget(SaleProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedProduct != widget.selectedProduct) {
      _updateLineTotal();
    }
  }

  void _updateLineTotal() {
    final quantity = int.tryParse(widget.quantityController.text) ?? 0;
    final sellingPrice = widget.selectedProduct?.sellingPrice.toDouble() ?? 0;
    setState(() {
      _lineTotal = sellingPrice * quantity;
    });
    if (widget.onValueChanged != null) {
      Future.microtask(() => widget.onValueChanged?.call());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.index + 1}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Product ${widget.index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: widget.onRemove,
                  tooltip: 'Remove Product',
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Product Selection
            InkWell(
              onTap: widget.onSelectProduct,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.selectedProduct == null
                        ? Colors.grey.shade400
                        : AppColors.primary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      color: widget.selectedProduct == null
                          ? Colors.grey.shade600
                          : AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectedProduct == null
                                ? 'Select Product'
                                : widget.selectedProduct!.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: widget.selectedProduct == null
                                  ? FontWeight.normal
                                  : FontWeight.w600,
                              color: widget.selectedProduct == null
                                  ? Colors.grey.shade600
                                  : Colors.black87,
                            ),
                          ),
                          if (widget.selectedProduct != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Batch: ${widget.selectedProduct!.batchNo} | Stock: ${widget.selectedProduct!.quantity}',
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
            const SizedBox(height: 12),
            // Selling Price and Quantity
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selling Price',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rs. ${widget.selectedProduct?.sellingPrice ?? 0}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: widget.quantityController,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      hintText: '0',
                      prefixIcon: const Icon(Icons.numbers),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Line Total
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.successBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Line Total',
                    style: TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Rs. ${_lineTotal.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
