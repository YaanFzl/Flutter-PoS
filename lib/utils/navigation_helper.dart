import 'package:flutter/material.dart';

class NavigationHelper {
  // Navigate to Payment Selection with total amount
  static void navigateToPaymentSelection(BuildContext context, double totalAmount) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentSelectionScreen(),
      ),
    );
  }

  // Navigate to Payment Confirmation with order details
  static void navigateToPaymentConfirmation(
    BuildContext context,
    String orderId,
    double amount,
    String paymentMethod,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentConfirmationScreen(),
      ),
    );
  }

  // Navigate to Delivery Order Details
  static void navigateToDeliveryOrderDetails(BuildContext context, String orderId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DeliveryOrderDetailsScreen(),
      ),
    );
  }

  // Navigate back to home (clear all routes)
  static void navigateToHome(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  // Show success message
  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF13EC5B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Show error message
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFFF3B30),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Show confirmation dialog
  static Future<bool> showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // Show issue report dialog
  static void showIssueDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Laporkan Masalah'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Jelaskan masalah yang terjadi...',
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              showSuccessSnackBar(context, 'Laporan telah dikirim');
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }
}

// Import statements will be added when screens use this helper
class PaymentSelectionScreen extends StatelessWidget {
  const PaymentSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class PaymentConfirmationScreen extends StatelessWidget {
  const PaymentConfirmationScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class DeliveryOrderDetailsScreen extends StatelessWidget {
  const DeliveryOrderDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}
