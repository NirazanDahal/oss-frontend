import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_bloc.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_event.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_footer_link.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  double _getMaxWidth() {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 420;
    if (width > 600) return 480;
    return double.infinity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: _getMaxWidth()),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const AuthHeader(
                        title: "Create Account",
                        subtitle: "Join OSS POS today",
                        icon: Icons.person_add_alt_1,
                      ),
                      const SizedBox(height: 40),

                      AuthTextField(
                        controller: _nameController,
                        hint: "Full Name",
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        controller: _emailController,
                        hint: "Email",
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        controller: _passwordController,
                        hint: "Password",
                        icon: Icons.lock_outline,
                        obscureText: true,
                      ),
                      const SizedBox(height: 32),

                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSuccessState) {
                            SnackUtils.showSuccess(
                              ResponseConstants.registerSuccessMessage,
                            );
                            Navigator.pop(context);
                          }
                          if (state is RegisterFailureState)
                            SnackUtils.showError(state.error.error);
                        },
                        builder: (context, state) {
                          return PrimaryButton(
                            text: "Create Account",
                            isLoading: state is RegisterLoadingState,
                            onPressed: () {
                              context.read<RegisterBloc>().add(
                                RegisterSubmittedEvent(
                                  _nameController.text.trim(),
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                ),
                              );
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 20),
                      AuthFooterLink(
                        text: "Already have an account?",
                        linkText: "Sign In",
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
