import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/common/empty_state.dart';
import 'delivery_order_details_screen.dart';
import 'widgets/delivery_order_card.dart';
import 'widgets/kanban_column.dart';

class DeliveryIntegrationScreen extends StatelessWidget {
  const DeliveryIntegrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final isTablet = screenWidth > 600;

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
            if (isDesktop) ...[
              const SizedBox(width: 48),
              _buildChip('Semua Pesanan', isActive: true),
              const SizedBox(width: 8),
              _buildChip('GoFood'),
              const SizedBox(width: 8),
              _buildChip('GrabFood'),
            ],
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              children: [
                if (isTablet) ...[
                  const Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                  const SizedBox(width: 8),
                  const Text('26 Okt 2023', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 16),
                  const Icon(Icons.schedule, color: Colors.grey, size: 20),
                  const SizedBox(width: 8),
                  const Text('10:30 AM', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 24),
                ],
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900; // Breakpoint for Kanban

          if (isMobile) {
            return DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: const TabBar(
                      labelColor: AppColors.primary,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: AppColors.primary,
                      tabs: [
                        Tab(text: 'Pesanan Baru'),
                        Tab(text: 'Sedang Dimasak'),
                        Tab(text: 'Siap Diambil'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Tab 1: New Orders
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: KanbanColumn(
                            title: 'Pesanan Baru',
                            color: const Color(0xFFFF9500),
                            count: 3,
                            children: [
                              DeliveryOrderCard(
                                orderId: '#GF-12345',
                                platform: 'GoFood',
                                timeAgo: '5 menit lalu',
                                status: 'BARU',
                                statusColor: const Color(0xFFFF9500),
                                items: const ['2x Burger Klasik', '1x Kentang Besar', '1x Coke'],
                                showActions: true,
                                onReject: () {},
                                onAccept: () {},
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DeliveryOrderDetailsScreen(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              DeliveryOrderCard(
                                orderId: '#GR-67890',
                                platform: 'GrabFood',
                                timeAgo: '2 menit lalu',
                                status: 'BARU',
                                statusColor: const Color(0xFFFF9500),
                                items: const ['1x Wrap Sayur', '1x Salad, 1x Air Mineral'],
                                showActions: true,
                                onReject: () {},
                                onAccept: () {},
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DeliveryOrderDetailsScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        // Tab 2: Preparing
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: KanbanColumn(
                            title: 'Sedang Dimasak',
                            color: const Color(0xFF4A90E2),
                            count: 1,
                            children: [
                              DeliveryOrderCard(
                                orderId: '#FP-55443',
                                platform: 'FoodPanda',
                                timeAgo: 'Diterima 8 menit lalu',
                                status: 'MEMASAK',
                                statusColor: const Color(0xFF4A90E2),
                                items: const ['1x Pizza Ayam Pedas', '2x Roti Bawang'],
                                primaryActionLabel: 'Tandai Siap',
                                primaryActionIcon: Icons.check_circle,
                                onPrimaryAction: () {},
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DeliveryOrderDetailsScreen(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              const EmptyState(
                                icon: Icons.ramen_dining,
                                message: 'Tidak ada pesanan lain yang dimasak.',
                                subMessage: 'Pesanan baru yang diterima akan muncul di sini.',
                              ),
                            ],
                          ),
                        ),
                        // Tab 3: Ready
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: KanbanColumn(
                            title: 'Siap Diambil',
                            color: const Color(0xFF34C759),
                            count: 1,
                            children: [
                              DeliveryOrderCard(
                                orderId: '#GR-11221',
                                platform: 'GrabFood',
                                timeAgo: 'Siap sejak 3 menit',
                                status: 'SIAP',
                                statusColor: const Color(0xFF34C759),
                                items: const ['3x Piring Sushi'],
                                primaryActionLabel: 'Pesanan Diambil',
                                primaryActionIcon: Icons.local_shipping,
                                primaryActionColor: Colors.grey.shade200,
                                primaryActionTextColor: Colors.black87,
                                onPrimaryAction: () {},
                              ),
                              const SizedBox(height: 16),
                              const EmptyState(
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
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column: New Orders
                Expanded(
                  child: KanbanColumn(
                    title: 'Pesanan Baru',
                    color: const Color(0xFFFF9500), // status-new
                    count: 3,
                    children: [
                      DeliveryOrderCard(
                        orderId: '#GF-12345',
                        platform: 'GoFood',
                        timeAgo: '5 menit lalu',
                        status: 'BARU',
                        statusColor: const Color(0xFFFF9500),
                        items: const ['2x Burger Klasik', '1x Kentang Besar', '1x Coke'],
                        showActions: true,
                        onReject: () {},
                        onAccept: () {},
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DeliveryOrderDetailsScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      DeliveryOrderCard(
                        orderId: '#GR-67890',
                        platform: 'GrabFood',
                        timeAgo: '2 menit lalu',
                        status: 'BARU',
                        statusColor: const Color(0xFFFF9500),
                        items: const ['1x Wrap Sayur', '1x Salad, 1x Air Mineral'],
                        showActions: true,
                        onReject: () {},
                        onAccept: () {},
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DeliveryOrderDetailsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Column: Preparing
                Expanded(
                  child: KanbanColumn(
                    title: 'Sedang Dimasak',
                    color: const Color(0xFF4A90E2), // status-preparing
                    count: 1,
                    children: [
                      DeliveryOrderCard(
                        orderId: '#FP-55443',
                        platform: 'FoodPanda',
                        timeAgo: 'Diterima 8 menit lalu',
                        status: 'MEMASAK',
                        statusColor: const Color(0xFF4A90E2),
                        items: const ['1x Pizza Ayam Pedas', '2x Roti Bawang'],
                        primaryActionLabel: 'Tandai Siap',
                        primaryActionIcon: Icons.check_circle,
                        onPrimaryAction: () {},
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DeliveryOrderDetailsScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const EmptyState(
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
                  child: KanbanColumn(
                    title: 'Siap Diambil',
                    color: const Color(0xFF34C759), // status-ready
                    count: 1,
                    children: [
                      DeliveryOrderCard(
                        orderId: '#GR-11221',
                        platform: 'GrabFood',
                        timeAgo: 'Siap sejak 3 menit',
                        status: 'SIAP',
                        statusColor: const Color(0xFF34C759),
                        items: const ['3x Piring Sushi'],
                        primaryActionLabel: 'Pesanan Diambil',
                        primaryActionIcon: Icons.local_shipping,
                        primaryActionColor: Colors.grey.shade200,
                        primaryActionTextColor: Colors.black87,
                        onPrimaryAction: () {},
                      ),
                      const SizedBox(height: 16),
                      const EmptyState(
                        icon: Icons.restaurant,
                        message: 'Semua selesai!',
                        subMessage: 'Tidak ada pesanan yang menunggu diambil.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
}

