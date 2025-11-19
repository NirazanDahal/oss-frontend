import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/dialog_utils.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/costomer/blocs/bloc/add_customer_bloc.dart';
import 'package:oss_frontend/features/costomer/blocs/bloc/add_customer_event.dart';
import 'package:oss_frontend/features/costomer/blocs/bloc/add_customer_state.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AddCustomerBloc, AddCustomerState>(
        listener: (context, state) {
          if (state is AddCustomerSuccessState) {
            SnackUtils.showSuccess(ResponseConstants.addCustomerSuccessMessage);
          }
          if (state is AddCustomerFailureState) {
            SnackUtils.showError(state.error.error);
          }
        },
        builder: (context, state) {
          if (state is AddCustomerSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              final result = await DialogUtils.showAddMoreDialog(context);

              if (result == false) {
                Navigator.pop(context);
              } else {
                _nameController.clear();
                _phoneController.clear();
                _addressController.clear();
              }
              context.read<AddCustomerBloc>().add(ResetAddCustomerStateEvent());
            });
          }
          return Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  context.read<AddCustomerBloc>().add(
                    AddCustomerSubmittedEvent(
                      _nameController.text.trim(),
                      _phoneController.text.trim(),
                      _addressController.text.trim(),
                    ),
                  );
                },
                child: Text('Add Customer'),
              ),
            ],
          );
        },
      ),
    );
  }
}
