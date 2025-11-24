import 'package:flutter/material.dart';


class DeliveryIntegrationScreen extends StatelessWidget {
  const DeliveryIntegrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // background-light from HTML
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.restaurant_menu, color: Color(0xFF2E7D32), size: 32),
            const SizedBox(width: 12),
            const Text(
              'The Good Fork',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 48),
            // Chips (Hidden on small screens in HTML, but we can show them or hide them)
            // For simplicity, I'll add a few
            _buildChip('Semua Pesanan', isActive: true),
            const SizedBox(width: 8),
            _buildChip('GoFood'),
            const SizedBox(width: 8),
            _buildChip('GrabFood'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                const Text('26 Okt 2023', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                const Icon(Icons.schedule, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                const Text('10:30 AM', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                const SizedBox(width: 24),
                Stack(
                  children: [
                    const Icon(Icons.notifications, color: Colors.grey, size: 28),
                    Positioned(
                      right: 2,
                      top: 2,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF3B30), // status-rejected
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.black12),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column: New Orders
            Expanded(
              child: _buildKanbanColumn(
                title: 'Pesanan Baru',
                color: const Color(0xFFFF9500), // status-new
                count: 3,
                children: [
                  _buildOrderCard(
                    orderId: '#GF-12345',
                    platform: 'GoFood',
                    timeAgo: '5 menit lalu',
                    status: 'BARU',
                    statusColor: const Color(0xFFFF9500),
                    items: ['2x Burger Klasik', '1x Kentang Besar', '1x Coke'],
                    showActions: true,
                  ),
                  const SizedBox(height: 16),
                  _buildOrderCard(
                    orderId: '#GR-67890',
                    platform: 'GrabFood',
                    timeAgo: '2 menit lalu',
                    status: 'BARU',
                    statusColor: const Color(0xFFFF9500),
                    items: ['1x Wrap Sayur', '1x Salad, 1x Air Mineral'],
                    showActions: true,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // Column: Preparing
            Expanded(
              child: _buildKanbanColumn(
                title: 'Sedang Dimasak',
                color: const Color(0xFF4A90E2), // status-preparing
                count: 1,
                children: [
                  _buildOrderCard(
                    orderId: '#FP-55443',
                    platform: 'FoodPanda',
                    timeAgo: 'Diterima 8 menit lalu',
                    status: 'MEMASAK',
                    statusColor: const Color(0xFF4A90E2),
                    items: ['1x Pizza Ayam Pedas', '2x Roti Bawang'],
                    primaryActionLabel: 'Tandai Siap',
                    primaryActionIcon: Icons.check_circle,
                  ),
                  const SizedBox(height: 16),
                  _buildEmptyState(
                    icon: Icons.ramen_dining,
                    message: 'Tidak ada pesanan lain yang dimasak.',
                    subMessage: 'Pesanan baru yang diterima akan muncul di sini.',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // Column: Ready for Pickup
            Expanded(
              child: _buildKanbanColumn(
                title: 'Siap Diambil',
                color: const Color(0xFF34C759), // status-ready
                count: 1,
                children: [
                  _buildOrderCard(
                    orderId: '#GR-11221',
                    platform: 'GrabFood',
                    timeAgo: 'Siap sejak 3 menit',
                    status: 'SIAP',
                    statusColor: const Color(0xFF34C759),
                    items: ['3x Piring Sushi'],
                    primaryActionLabel: 'Pesanan Diambil',
                    primaryActionIcon: Icons.local_shipping,
                    primaryActionColor: Colors.grey.shade200,
                    primaryActionTextColor: Colors.black87,
                  ),
                  const SizedBox(height: 16),
                  _buildEmptyState(
                    icon: Icons.restaurant,
                    message: 'Semua selesai!',
                    subMessage: 'Tidak ada pesanan yang menunggu diambil.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF2E7D32).withAlpha(51) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? const Color(0xFF2E7D32) : Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildKanbanColumn({
    required String title,
    required Color color,
    required int count,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: color.withAlpha(51),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required String platform,
    required String timeAgo,
    required String status,
    required Color statusColor,
    required List<String> items,
    bool showActions = false,
    String? primaryActionLabel,
    IconData? primaryActionIcon,
    Color? primaryActionColor,
    Color? primaryActionTextColor,
  }) {
    return Container(
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                onPressed: () {},
                icon: Icon(primaryActionIcon),
                label: Text(primaryActionLabel),
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
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String message,
    required String subMessage,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, style: BorderStyle.solid), // Dashed hard in Flutter without package
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
