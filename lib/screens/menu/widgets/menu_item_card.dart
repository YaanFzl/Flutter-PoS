import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

/// Menu item card widget
/// Displays menu item with name, description, price, availability toggle, and edit button
class MenuItemCard extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final bool isAvailable;
  final VoidCallback onEdit;
  final ValueChanged<bool> onAvailabilityChanged;

  const MenuItemCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.isAvailable,
    required this.onEdit,
    required this.onAvailabilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Opacity(
        opacity: isAvailable ? 1.0 : 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      isAvailable ? 'Tersedia' : 'Tidak Tersedia',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Switch(
                      value: isAvailable,
                      onChanged: (val) {
                        onAvailabilityChanged(val);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              val
                                  ? '$name sekarang tersedia'
                                  : '$name tidak tersedia',
                            ),
                            backgroundColor: AppColors.primary,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      thumbColor: WidgetStateProperty.all(
                        isAvailable ? AppColors.primary : Colors.grey,
                      ),
                      trackColor: WidgetStateProperty.all(
                        isAvailable
                            ? AppColors.primary.withAlpha(77)
                            : Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  color: AppColors.primary,
                  tooltip: 'Edit',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
