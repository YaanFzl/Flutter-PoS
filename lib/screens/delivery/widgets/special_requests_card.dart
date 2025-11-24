import 'package:flutter/material.dart';

class SpecialRequestsCard extends StatelessWidget {
  final String request;

  const SpecialRequestsCard({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Permintaan Khusus', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEC107).withAlpha(26), // accent-yellow-bg
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              request,
              style: const TextStyle(color: Color(0xFFB38600)), // darker yellow
            ),
          ),
        ],
      ),
    );
  }
}
