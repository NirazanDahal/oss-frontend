import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oss_frontend/core/constants/response_constants.dart';
import 'package:oss_frontend/core/routes/app_routes.dart';
import 'package:oss_frontend/core/utils/snack_utils.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_bloc.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_event.dart';
import 'package:oss_frontend/features/auth/blocs/login/login_state.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_bloc.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_event.dart';
import 'package:oss_frontend/features/auth/blocs/register/register_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            SnackUtils.showSuccess(ResponseConstants.loginSuccessMessage);
          }
          if (state is LoginFailureState) {
            SnackUtils.showError(state.error.error);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: 5),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(
                      LoginSubmittedEvent(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      ),
                    );
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.registerScreen);
                  },
                  child: Text("Don't have and account? Register here"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
