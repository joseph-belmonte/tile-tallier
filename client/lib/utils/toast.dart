import 'package:flutter/material.dart';

/// A service for showing toasts.
class ToastService {
  static void _show(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    // First, clear any existing toasts
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red.shade600 : null,
        content: Text(message),
      ),
    );
  }

  /// Shows a message toast.
  static void message(BuildContext context, String message) {
    _show(context, message);
  }

  /// Shows an error toast.
  static void error(BuildContext context, String message) {
    _show(context, message, isError: true);
  }
}
