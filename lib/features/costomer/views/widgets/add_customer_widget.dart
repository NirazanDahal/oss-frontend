import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/costomer/blocs/add_customer/add_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/blocs/add_customer/add_customer_event.dart';
import 'package:oss_frontend/features/costomer/blocs/add_customer/add_customer_state.dart';
import '../widgets/customer_text_field.dart';

class AddCustomerWidget extends StatefulWidget {
  const AddCustomerWidget({super.key});

  @override
  State<AddCustomerWidget> createState() => _AddCustomerWidgetState();
}

class _AddCustomerWidgetState extends State<AddCustomerWidget> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),

            // Title
            const Text(
              "Add New Customer",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
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
                      // validator: (v) =>
                      //     v?.trim().isEmpty == true ? "Name is required" : null,
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

            // Submit Button
            BlocConsumer<AddCustomerBloc, AddCustomerState>(
              listener: (context, state) {
                if (state is AddCustomerSuccessState) {
                  SnackUtils.showSuccess(
                    context,
                    ResponseConstants.addCustomerSuccessMessage,
                  );
                  Navigator.pop(context);
                }
                if (state is AddCustomerFailureState) {
                  SnackUtils.showError(context, state.error.error);
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: state is AddCustomerLoadingState
                        ? null
                        : () {
                            if (_nameController.text.isNotEmpty ||
                                _phoneController.text.isNotEmpty ||
                                _addressController.text.isNotEmpty) {
                              context.read<AddCustomerBloc>().add(
                                AddCustomerSubmittedEvent(
                                  _nameController.text.trim(),
                                  _phoneController.text.trim(),
                                  _addressController.text.trim(),
                                ),
                              );
                            } else {
                              SnackUtils.showError(
                                context,
                                ResponseConstants
                                    .addCustomerValidationErrorMessage,
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
                    child: state is AddCustomerLoadingState
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Add Customer",
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
