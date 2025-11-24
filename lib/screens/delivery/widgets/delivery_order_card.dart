import 'package:flutter/material.dart';

class DeliveryOrderCard extends StatelessWidget {
  final String orderId;
  final String platform;
  final String timeAgo;
  final String status;
  final Color statusColor;
  final List<String> items;
  final bool showActions;
  final String? primaryActionLabel;
  final IconData? primaryActionIcon;
  final Color? primaryActionColor;
  final Color? primaryActionTextColor;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onTap;

  const DeliveryOrderCard({
    super.key,
    required this.orderId,
    required this.platform,
    required this.timeAgo,
    required this.status,
    required this.statusColor,
    required this.items,
    this.showActions = false,
    this.primaryActionLabel,
    this.primaryActionIcon,
    this.primaryActionColor,
    this.primaryActionTextColor,
    this.onAccept,
    this.onReject,
    this.onPrimaryAction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Placeholder for logo
                    Container(
                      width: 24,
                      height: 24,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image, size: 16),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderId,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          timeAgo,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 8), // Spacing instead of divider
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
            if (showActions) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onReject,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                      ),
                      child: const Text('Tolak'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
                      child: const Text('Terima'),
                    ),
                  ),
                ],
              ),
            ],
            if (primaryActionLabel != null) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onPrimaryAction,
                  icon: Icon(primaryActionIcon),
                  label: Text(primaryActionLabel!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryActionColor ?? const Color(0xFF2E7D32),
                    foregroundColor: primaryActionTextColor ?? Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
