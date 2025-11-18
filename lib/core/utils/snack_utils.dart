import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SnackUtils {
  //Global key for accessing scaffold messenger anywhere in the app
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  //Generic show method
  static void show(String message, {Color? backgroundColor}) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: AppColors.background)),
        backgroundColor: backgroundColor ?? AppColors.primary,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static void showSuccess(String message) {
    show(message, backgroundColor: Colors.green);
  }

  static void showError(String message) {
    show(message, backgroundColor: Colors.redAccent);
  }

  static void showInfo(String message) {
    show(message, backgroundColor: Colors.blueAccent);
  }
}
