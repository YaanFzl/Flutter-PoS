import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/common/status_badge.dart';

/// Order card widget for dashboard
/// Displays order details with items, totals, and action button
class OrderCard extends StatelessWidget {
  final String title;
  final String timeAgo;
  final List<Map<String, String>> items;
  final String subtotal;
  final String tax;
  final String total;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.title,
    required this.timeAgo,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.total,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textLight,
                        ),
                      ),
                      const StatusBadge(
                        label: 'Baru',
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeAgo,
                    style: const TextStyle(
                      color: AppColors.textMutedLight,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.black12),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.textLight,
                        ),
                      ),
                      Text(
                        item['price']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal', style: TextStyle(color: AppColors.textMutedLight)),
                      Text(subtotal, style: const TextStyle(color: AppColors.textMutedLight)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Pajak (10%)', style: TextStyle(color: AppColors.textMutedLight)),
                      Text(tax, style: const TextStyle(color: AppColors.textMutedLight)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Colors.black12),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textLight,
                        ),
                      ),
                      Text(
                        total,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textLight,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow),
                      SizedBox(width: 8),
                      Text(
                        'Mulai Memasak',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
