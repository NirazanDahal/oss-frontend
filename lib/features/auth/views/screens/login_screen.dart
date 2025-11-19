import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/app_colors.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_bloc.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_event.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_footer_link.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
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
                        title: "Welcome Back",
                        subtitle: "Sign in to your account",
                        icon: Icons.storefront,
                      ),
                      const SizedBox(height: 40),

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

                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccessState) {
                            SnackUtils.showSuccess(
                              ResponseConstants.loginSuccessMessage,
                            );
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.dashBoardScreen,
                              (r) => false,
                            );
                          }
                          if (state is LoginFailureState) {
                            SnackUtils.showError(state.error.error);
                          }
                        },
                        builder: (context, state) {
                          return PrimaryButton(
                            text: "Sign In",
                            isLoading: state is LoginLoadingState,
                            onPressed: () {
                              context.read<LoginBloc>().add(
                                LoginSubmittedEvent(
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
                        text: "Don't have an account?",
                        linkText: "Register here",
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.registerScreen,
                        ),
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
