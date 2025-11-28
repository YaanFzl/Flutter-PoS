import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

import 'delivery_order_details_screen.dart';
import 'widgets/delivery_order_card.dart';
import 'widgets/kanban_column.dart';

import '../../services/api_service.dart';
import '../../models/transaction_model.dart';

class DeliveryIntegrationScreen extends StatefulWidget {
  const DeliveryIntegrationScreen({super.key});

  @override
  State<DeliveryIntegrationScreen> createState() => _DeliveryIntegrationScreenState();
}

class _DeliveryIntegrationScreenState extends State<DeliveryIntegrationScreen> {
  final ApiService _apiService = ApiService();
  List<Transaction> _transactions = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final transactions = await _apiService.getTransactions(rowsPerPage: 100);
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _updateStatus(int id, String newStatus) async {
    // Optimistic update
    final index = _transactions.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final originalTransaction = _transactions[index];
    
    setState(() {
      _transactions[index] = Transaction(
        id: originalTransaction.id,
        idCashier: originalTransaction.idCashier,
        type: originalTransaction.type,
        tableNumber: originalTransaction.tableNumber,
        customerName: originalTransaction.customerName,
        customerEmail: originalTransaction.customerEmail,
        paymentMethod: originalTransaction.paymentMethod,
        status: newStatus,
        totalPrice: originalTransaction.totalPrice,
        createdAt: originalTransaction.createdAt,
        items: originalTransaction.items,
      );
    });

    try {
      await _apiService.updateTransaction(id, {'status': newStatus});
      // If successful, we could reload, but let's keep local state to avoid flickering
    } catch (e) {
      // If backend fails, we keep the local change but warn the user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
             content: Text('Status updated locally (Backend limitation)'),
             duration: Duration(seconds: 2),
           ),
        );
      }
    }
  }

  String _getTimeAgo(String createdAt) {
    final created = DateTime.parse(createdAt);
    final now = DateTime.now();
    final difference = now.difference(created);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}j lalu';
    } else {
      return '${difference.inDays}h lalu';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      backgroundColor: Colors.transparent, // Let MainLayout background show
      appBar: AppBar(
        backgroundColor: Colors.white.withAlpha(200),
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.soup_kitchen_rounded, color: AppColors.primary, size: 28),
            const SizedBox(width: 12),
            const Text(
              'Kitchen & Delivery',
              style: TextStyle(
                color: AppColors.textLight,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            if (isDesktop) ...[
              const SizedBox(width: 48),
              _buildChip('Semua Pesanan', isActive: true),
              const SizedBox(width: 8),
              _buildChip('Dine In'),
              const SizedBox(width: 8),
              _buildChip('Take Away'),
            ],
          ],
        ),
        actions: [
          IconButton(
            onPressed: _loadTransactions,
            icon: const Icon(Icons.refresh, color: AppColors.textMutedLight),
          ),
          const SizedBox(width: 16),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.black12),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (_error != null) {
            return Center(child: Text('Error: $_error'));
          }

          // Filter transactions
          // Show all active orders in New, plus specific statuses in other columns
          final newOrders = _transactions.where((t) => 
            t.status != 'completed' && 
            t.status != 'canceled' && 
            t.status != 'preparing' && 
            t.status != 'ready'
          ).toList();
          
          final preparingOrders = _transactions.where((t) => t.status == 'preparing').toList();
          final readyOrders = _transactions.where((t) => t.status == 'ready').toList();
          
          return LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 900;

              if (isMobile) {
                return DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white.withAlpha(200),
                        child: const TabBar(
                          labelColor: AppColors.primary,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: AppColors.primary,
                          tabs: [
                            Tab(text: 'Baru'),
                            Tab(text: 'Memasak'),
                            Tab(text: 'Siap'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildKanbanList(newOrders, 'Baru', const Color(0xFFFF9500), context),
                            _buildKanbanList(preparingOrders, 'Memasak', const Color(0xFF4A90E2), context),
                            _buildKanbanList(readyOrders, 'Siap', const Color(0xFF34C759), context),
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
                    Expanded(child: _buildKanbanColumn('Pesanan Baru', const Color(0xFFFF9500), newOrders, context)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildKanbanColumn('Sedang Dimasak', const Color(0xFF4A90E2), preparingOrders, context)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildKanbanColumn('Siap Diambil', const Color(0xFF34C759), readyOrders, context)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildKanbanColumn(String title, Color color, List<Transaction> orders, BuildContext context) {
    return KanbanColumn(
      title: title,
      color: color,
      count: orders.length,
      children: orders.map((order) => _buildOrderCard(order, color, context)).toList(),
    );
  }

  Widget _buildKanbanList(List<Transaction> orders, String title, Color color, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: KanbanColumn(
        title: title,
        color: color,
        count: orders.length,
        children: orders.map((order) => _buildOrderCard(order, color, context)).toList(),
      ),
    );
  }

  Widget _buildOrderCard(Transaction order, Color color, BuildContext context) {
    // Determine actions based on status
    bool showActions = false;
    String? primaryActionLabel;
    IconData? primaryActionIcon;
    VoidCallback? onPrimaryAction;
    VoidCallback? onAccept;
    VoidCallback? onReject;

    if (order.status == 'paid' || order.status == 'waiting_payment') {
      showActions = true;
      onAccept = () => _updateStatus(order.id, 'preparing');
      onReject = () {}; // Implement reject logic if needed
    } else if (order.status == 'preparing') {
      primaryActionLabel = 'Tandai Siap';
      primaryActionIcon = Icons.check_circle_outline;
      onPrimaryAction = () => _updateStatus(order.id, 'ready');
    } else if (order.status == 'ready') {
      primaryActionLabel = 'Selesai';
      primaryActionIcon = Icons.done_all;
      onPrimaryAction = () => _updateStatus(order.id, 'completed');
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DeliveryOrderCard(
        orderId: '#${order.id}',
        platform: order.type == 'take_away' ? 'Take Away' : 'Dine In',
        timeAgo: _getTimeAgo(order.createdAt),
        status: order.status.toUpperCase(),
        statusColor: color,
        items: order.items.map((item) => '${item.quantity}x ${item.productName}').toList(),
        showActions: showActions,
        primaryActionLabel: primaryActionLabel,
        primaryActionIcon: primaryActionIcon,
        onAccept: onAccept,
        onReject: onReject,
        onPrimaryAction: onPrimaryAction,
        onTap: () {
           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeliveryOrderDetailsScreen(), // Pass transaction if needed
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
        color: isActive ? AppColors.primary.withAlpha(51) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? AppColors.primary : Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.primary : Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
