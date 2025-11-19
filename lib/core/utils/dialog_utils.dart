import 'package:flutter/material.dart';

class DialogUtils {
  static Future<bool?> showAddMoreDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Customer added!"),
          content: const Text("Do you want to add more customers?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // No
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Yes
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
