import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';

class PurchaseProductCard extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController rateController;
  final TextEditingController quantityController;
  final VoidCallback onRemove;
  final int index;
  final VoidCallback? onValueChanged;

  const PurchaseProductCard({
    super.key,
    required this.nameController,
    required this.rateController,
    required this.quantityController,
    required this.onRemove,
    required this.index,
    this.onValueChanged,
  });

  @override
  State<PurchaseProductCard> createState() => _PurchaseProductCardState();
}

class _PurchaseProductCardState extends State<PurchaseProductCard> {
  double _lineTotal = 0.0;

  @override
  void initState() {
    super.initState();
    // Add listeners to update line total in real-time
    widget.rateController.addListener(_updateLineTotal);
    widget.quantityController.addListener(_updateLineTotal);
    _updateLineTotal();
  }

  @override
  void dispose() {
    widget.rateController.removeListener(_updateLineTotal);
    widget.quantityController.removeListener(_updateLineTotal);
    super.dispose();
  }

  void _updateLineTotal() {
    final rate = double.tryParse(widget.rateController.text) ?? 0;
    final quantity = int.tryParse(widget.quantityController.text) ?? 0;
    setState(() {
      _lineTotal = rate * quantity;
    });
    // Notify parent to update grand total (defer to avoid setState during build)
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
            TextField(
              controller: widget.nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                hintText: 'Enter product name',
                prefixIcon: const Icon(Icons.inventory_2_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.rateController,
                    decoration: InputDecoration(
                      labelText: 'Rate',
                      hintText: '0.00',
                      prefixIcon: const Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
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
