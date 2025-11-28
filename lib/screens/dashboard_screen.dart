import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'dashboard/widgets/order_card.dart';
import 'payment/payment_selection_screen.dart';
import '../services/api_service.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Transaction>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    // Removed status filter to show all transactions for debugging
    _transactionsFuture = _apiService.getTransactions();
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  String _getTimeAgo(String createdAt) {
    final created = DateTime.parse(createdAt);
    final now = DateTime.now();
    final difference = now.difference(created);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else {
      return '${difference.inDays} hari lalu';
    }
  }

  Future<void> _createTestTransaction() async {
    try {
      await _apiService.createTransaction({
        "id_cashier": 1,
        "type": "makan_ditempat",
        "table_number": 99,
        "customer_name": "Test User",
        "payment_method": "cash",
        "status": "waiting_payment",
        "items": [
          {
            "id_product": 1, // Assuming ID 1 exists
            "price": 10000,
            "quantity": 1
          }
        ]
      });
      setState(() {
        _transactionsFuture = _apiService.getTransactions();
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Test transaction created')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create test transaction: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      floatingActionButton: FloatingActionButton(
        onPressed: _createTestTransaction,
        child: const Icon(Icons.add),
      ),
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
                    FutureBuilder<List<Transaction>>(
                      future: _transactionsFuture,
                      builder: (context, snapshot) {
                        final count = snapshot.hasData ? snapshot.data!.length : 0;
                        return Text(
                          'Pesanan ($count)',
                          style: TextStyle(
                            fontSize: isMobile ? 24 : 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textLight,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: padding),
                Expanded(
                  child: FutureBuilder<List<Transaction>>(
                    future: _transactionsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Tidak ada pesanan'));
                      }

                      final transactions = snapshot.data!;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = transactions[index];
                          return OrderCard(
                            title: transaction.tableNumber != null 
                                ? 'Meja ${transaction.tableNumber}' 
                                : 'Pesanan #${transaction.id}',
                            timeAgo: _getTimeAgo(transaction.createdAt),
                            items: transaction.items.map((item) => {
                              'name': '${item.quantity}x ${item.productName}',
                              'price': _formatCurrency(item.subtotal),
                            }).toList(),
                            subtotal: _formatCurrency(transaction.totalPrice), // Simplified
                            tax: _formatCurrency((transaction.totalPrice * 0.1).round()), // Simplified tax
                            total: _formatCurrency((transaction.totalPrice * 1.1).round()), // Simplified total
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentSelectionScreen(transaction: transaction),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
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
