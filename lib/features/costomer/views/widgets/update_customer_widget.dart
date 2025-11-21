import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/costomer/blocs/update_customer/update_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/blocs/update_customer/update_customer_event.dart';
import 'package:oss_frontend/features/costomer/blocs/update_customer/update_customer_state.dart';
import '../widgets/customer_text_field.dart';

class UpdateCustomerWidget extends StatefulWidget {
  final dynamic customer;
  const UpdateCustomerWidget({super.key, required this.customer});

  @override
  State<UpdateCustomerWidget> createState() => _UpdateCustomerWidgetState();
}

class _UpdateCustomerWidgetState extends State<UpdateCustomerWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameController.text = widget.customer.name.trim();
    _phoneController.text = widget.customer.phone.trim();
    _addressController.text = widget.customer.address.trim();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Update Customer",
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
                      CustomerTextField(
                        controller: _nameController,
                        label: "Full Name",
                        icon: Icons.person_outline,
                        textCapitalization: TextCapitalization.words,
                        // validator: (v) => v?.trim().isEmpty == true
                        //     ? "Name is required"
                        //     : null,
                      ),
                      const SizedBox(height: 16),

                      CustomerTextField(
                        controller: _phoneController,
                        label: "Phone Number",
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        // validator: (v) => v?.trim().isEmpty == true
                        //     ? "Phone is required"
                        //     : null,
                      ),
                      const SizedBox(height: 16),

                      CustomerTextField(
                        controller: _addressController,
                        label: "Address",
                        icon: Icons.location_on_outlined,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),

            // Submit Button
            BlocConsumer<UpdateCustomerBloc, UpdateCustomerState>(
              listener: (context, state) {
                if (state is UpdateCustomerSuccessState) {
                  SnackUtils.showSuccess(
                    context,
                    ResponseConstants.updateCustomerSuccessMessage,
                  );
                  Navigator.pop(context);
                }
                if (state is UpdateCustomerFailureState) {
                  SnackUtils.showError(context, state.errorResponse.error);
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: state is UpdateCustomerLoadingState
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              if (_nameController.text.trim() !=
                                      widget.customer.name.trim() ||
                                  _phoneController.text.trim() !=
                                      widget.customer.phone.trim() ||
                                  _addressController.text.trim() !=
                                      widget.customer.address.trim()) {
                                context.read<UpdateCustomerBloc>().add(
                                  UpdateCustomerSubmittedEvent(
                                    widget.customer.id,
                                    _nameController.text.trim(),
                                    _phoneController.text.trim(),
                                    _addressController.text.trim(),
                                  ),
                                );
                              } else {
                                SnackUtils.showInfo(
                                  context,
                                  ResponseConstants
                                      .updateCustomerValidationErrorMessage,
                                );
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: state is UpdateCustomerLoadingState
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Update Customer",
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
