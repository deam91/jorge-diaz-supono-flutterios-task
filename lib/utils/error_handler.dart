import 'package:flutter/material.dart';

class ErrorHandler {
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static Future<void> handleError(
    BuildContext context,
    dynamic error, {
    String? fallbackMessage,
  }) async {
    String message = fallbackMessage ?? 'An unexpected error occurred';

    if (error is Exception) {
      message = error.toString();
    }

    showError(context, message);

    // Log error for debugging
    debugPrint('Error: $error');
  }
}
