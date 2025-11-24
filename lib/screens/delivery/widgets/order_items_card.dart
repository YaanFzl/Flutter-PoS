import 'package:flutter/material.dart';

class OrderItemsCard extends StatelessWidget {
  final List<Map<String, String>> items;

  const OrderItemsCard({
    super.key,
    required this.items,
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
          const Text(
            'Item Pesanan',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == items.length - 1;
            return Column(
              children: [
                _buildOrderItem(
                  name: item['name']!,
                  price: item['price']!,
                  details: item['details'],
                ),
                if (!isLast) const Divider(height: 32),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOrderItem({required String name, required String price, String? details}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.fastfood, color: Colors.grey),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              Text(price, style: const TextStyle(color: Color(0xFF4C9A66), fontSize: 16)),
              if (details != null)
                Text(details, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
