import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transaction_model.dart';
import 'widgets/customer_info_card.dart';
import 'widgets/delivery_summary_card.dart';
import 'widgets/order_items_card.dart';
import 'widgets/special_requests_card.dart';

class DeliveryOrderDetailsScreen extends StatelessWidget {
  final Transaction? transaction;

  const DeliveryOrderDetailsScreen({super.key, this.transaction});

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    // Use transaction data if available, otherwise fallback (or show error/loading)
    // For now, if transaction is null, we might want to handle it gracefully or assume it's passed.
    // But since this screen might be accessed from other places (like Kanban), we should handle it.
    
    final items = transaction?.items.map((item) => {
      'name': '${item.quantity}x ${item.productName}',
      'price': _formatCurrency(item.subtotal),
      'details': item.variantName ?? '', // Assuming variantName holds details like "Pedas"
    }).toList() ?? [];

    final subtotal = transaction?.totalPrice ?? 0;
    final tax = (subtotal * 0.1).round(); // Simplified tax
    final total = subtotal + tax; // Simplified total logic

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // background-light
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Row(
          children: [
            // Logo placeholder
            Container(width: 32, height: 32, color: Colors.green),
            const SizedBox(width: 12),
            Text(
              transaction != null ? '#${transaction!.id}' : '#GRF-12095',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: const [
                Icon(Icons.wifi, color: Colors.grey),
                SizedBox(width: 8),
                Text('10:42 AM', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.black12),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1536), // max-w-screen-2xl
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 1000; // Breakpoint for 2-column layout

                if (isMobile) {
                  return Column(
                    children: [
                      // Order Details Section
                      Column(
                        children: [
                          // Order Items Card
                          OrderItemsCard(
                            items: items,
                          ),
                          const SizedBox(height: 24),
                          // Customer & Special Requests
                          LayoutBuilder(
                            builder: (context, innerConstraints) {
                              if (innerConstraints.maxWidth < 600) {
                                return Column(
                                  children: [
                                    CustomerInfoCard(
                                      name: transaction?.customerName ?? 'Pelanggan',
                                      phone: '+62 812-3456-7890', // Placeholder
                                      address: transaction?.customerEmail ?? '-', // Using email as address placeholder for now
                                    ),
                                    const SizedBox(height: 24),
                                    const SpecialRequestsCard(
                                      request: '-', // Placeholder
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomerInfoCard(
                                      name: transaction?.customerName ?? 'Pelanggan',
                                      phone: '+62 812-3456-7890',
                                      address: transaction?.customerEmail ?? '-',
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  const Expanded(
                                    child: SpecialRequestsCard(
                                      request: '-',
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          // Totals Card
                          DeliverySummaryCard(
                            subtotal: _formatCurrency(subtotal),
                            tax: _formatCurrency(tax),
                            deliveryFee: 'Rp 0', // Simplified
                            total: _formatCurrency(total),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Status & Actions Section
                      Column(
                        children: [
                          // Status Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              children: [
                                const Text('STATUS', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF28A745).withAlpha(26),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(color: Color(0xFF28A745), shape: BoxShape.circle),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text('Pesanan Baru', style: TextStyle(color: Color(0xFF28A745), fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Timer Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              children: const [
                                Text('ESTIMASI PENGAMBILAN DALAM', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                                SizedBox(height: 8),
                                Text('15:00', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFF4C9A66))), // primary
                                SizedBox(height: 4),
                                Text('Dipesan 2 menit lalu', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Actions Card
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Pesanan dikonfirmasi, mulai memasak'),
                                          backgroundColor: Color(0xFF13EC5B),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.check),
                                    label: const Text('Konfirmasi & Mulai Memasak'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4C9A66),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Pesanan siap diambil'),
                                          backgroundColor: Color(0xFF13EC5B),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.local_shipping),
                                    label: const Text('Siap Diambil'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4C9A66).withAlpha(51),
                                      foregroundColor: const Color(0xFF4C9A66),
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Pesanan sedang dicetak...'),
                                              backgroundColor: Color(0xFF13EC5B),
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.print),
                                        label: const Text('Cetak'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.grey.shade700,
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          final controller = TextEditingController();
                                          showDialog(
                                            context: context,
                                            builder: (dialogContext) => AlertDialog(
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
                                                  onPressed: () => Navigator.pop(dialogContext),
                                                  child: const Text('Batal'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(dialogContext);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text('Laporan telah dikirim'),
                                                        backgroundColor: Color(0xFF13EC5B),
                                                        behavior: SnackBarBehavior.floating,
                                                      ),
                                                    );
                                                  },
                                                  child: const Text('Kirim'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.report),
                                        label: const Text('Masalah'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.grey.shade700,
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                // Desktop/Tablet Layout (Row)
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Order Details (3/5 width)
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          // Order Items Card
                          OrderItemsCard(
                            items: items,
                          ),
                          const SizedBox(height: 24),
                          // Customer & Special Requests
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CustomerInfoCard(
                                  name: transaction?.customerName ?? 'Pelanggan',
                                  phone: '+62 812-3456-7890',
                                  address: transaction?.customerEmail ?? '-',
                                ),
                              ),
                              const SizedBox(width: 24),
                              const Expanded(
                                child: SpecialRequestsCard(
                                  request: '-',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Totals Card
                          DeliverySummaryCard(
                            subtotal: _formatCurrency(subtotal),
                            tax: _formatCurrency(tax),
                            deliveryFee: 'Rp 0',
                            total: _formatCurrency(total),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Right Column: Status & Actions (2/5 width)
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // Status Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              children: [
                                const Text('STATUS', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF28A745).withAlpha(26),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(color: Color(0xFF28A745), shape: BoxShape.circle),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text('Pesanan Baru', style: TextStyle(color: Color(0xFF28A745), fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Timer Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              children: const [
                                Text('ESTIMASI PENGAMBILAN DALAM', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                                SizedBox(height: 8),
                                Text('15:00', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFF4C9A66))), // primary
                                SizedBox(height: 4),
                                Text('Dipesan 2 menit lalu', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Actions Card
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Pesanan dikonfirmasi, mulai memasak'),
                                          backgroundColor: Color(0xFF13EC5B),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.check),
                                    label: const Text('Konfirmasi & Mulai Memasak'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4C9A66),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Pesanan siap diambil'),
                                          backgroundColor: Color(0xFF13EC5B),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.local_shipping),
                                    label: const Text('Siap Diambil'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4C9A66).withAlpha(51),
                                      foregroundColor: const Color(0xFF4C9A66),
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Pesanan sedang dicetak...'),
                                              backgroundColor: Color(0xFF13EC5B),
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.print),
                                        label: const Text('Cetak'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.grey.shade700,
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          final controller = TextEditingController();
                                          showDialog(
                                            context: context,
                                            builder: (dialogContext) => AlertDialog(
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
                                                  onPressed: () => Navigator.pop(dialogContext),
                                                  child: const Text('Batal'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(dialogContext);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text('Laporan telah dikirim'),
                                                        backgroundColor: Color(0xFF13EC5B),
                                                        behavior: SnackBarBehavior.floating,
                                                      ),
                                                    );
                                                  },
                                                  child: const Text('Kirim'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.report),
                                        label: const Text('Masalah'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.grey.shade700,
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
