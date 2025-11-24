import 'package:flutter/material.dart';

class DeliverySummaryCard extends StatelessWidget {
  final String subtotal;
  final String tax;
  final String deliveryFee;
  final String total;

  const DeliverySummaryCard({
    super.key,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.total,
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
        children: [
          _buildTotalRow('Subtotal', subtotal),
          const SizedBox(height: 8),
          _buildTotalRow('Pajak & Biaya', tax),
          const SizedBox(height: 8),
          _buildTotalRow('Biaya Pengiriman', deliveryFee),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Keseluruhan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(total, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
