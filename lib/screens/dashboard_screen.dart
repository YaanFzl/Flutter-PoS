import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'dashboard/widgets/order_card.dart';
import 'payment/payment_selection_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          final isTablet = constraints.maxWidth < 1100;
          final padding = isMobile ? 16.0 : 32.0;
          
          int crossAxisCount = 3;
          if (isMobile) {
            crossAxisCount = 1;
          } else if (isTablet) {
            crossAxisCount = 2;
          }

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pesanan Baru (3)',
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: padding),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 0.8,
                    children: [
                      OrderCard(
                        title: 'Pesanan #1024',
                        timeAgo: '2 menit lalu',
                        items: const [
                          {'name': '2x Pizza Margherita', 'price': 'Rp 240.000'},
                          {'name': '1x Coke', 'price': 'Rp 25.000'},
                        ],
                        subtotal: 'Rp 265.000',
                        tax: 'Rp 26.500',
                        total: 'Rp 291.500',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentSelectionScreen(),
                            ),
                          );
                        },
                      ),
                      OrderCard(
                        title: 'Meja 5',
                        timeAgo: '5 menit lalu',
                        items: const [
                          {'name': '1x Salad Caesar', 'price': 'Rp 125.000'},
                          {'name': '1x Pasta Carbonara', 'price': 'Rp 180.000'},
                          {'name': '2x Air Mineral', 'price': 'Rp 30.000'},
                        ],
                        subtotal: 'Rp 335.000',
                        tax: 'Rp 33.500',
                        total: 'Rp 368.500',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentSelectionScreen(),
                            ),
                          );
                        },
                      ),
                      OrderCard(
                        title: 'Pesanan #1022',
                        timeAgo: '8 menit lalu',
                        items: const [
                          {'name': '1x Burger Sapi', 'price': 'Rp 150.000'},
                          {'name': '1x Kentang Goreng', 'price': 'Rp 55.000'},
                          {'name': '1x Sprite', 'price': 'Rp 25.000'},
                        ],
                        subtotal: 'Rp 230.000',
                        tax: 'Rp 23.000',
                        total: 'Rp 253.000',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentSelectionScreen(),
                            ),
                          );
                        },
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
}
