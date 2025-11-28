import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'payment_confirmation_screen.dart';
import 'widgets/payment_method_card.dart';
import '../../models/transaction_model.dart';
import '../../services/api_service.dart';
import 'package:intl/intl.dart';

class PaymentSelectionScreen extends StatefulWidget {
  final Transaction transaction;

  const PaymentSelectionScreen({super.key, required this.transaction});

  @override
  State<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  String _selectedMethod = 'QRIS'; // Default selected
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  Future<void> _processPayment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _apiService.updateTransaction(widget.transaction.id, {
        'status': 'completed',
        'payment_method': _selectedMethod.toLowerCase().replaceAll(' ', '_'),
      });

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentConfirmationScreen(transaction: widget.transaction),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pembayaran dikonfirmasi'),
            backgroundColor: Color(0xFF13EC5B),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memproses pembayaran: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // TopAppBar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: AppColors.textLight),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      hoverColor: Colors.black12,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Pesanan #${widget.transaction.id}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
            ),
            
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 24,
                      vertical: isMobile ? 16 : 32,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 672), // max-w-2xl
                        child: Column(
                          children: [
                            // HeadlineText
                            const Text(
                              'Total yang Harus Dibayar',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textLight,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _formatCurrency(widget.transaction.totalPrice),
                              style: const TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 32),
                            
                            // TitleText
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Pilih Metode Pembayaran',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textLight,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // RadioList
                            LayoutBuilder(
                              builder: (context, constraints) {
                                // Simple responsive check
                                bool isWide = constraints.maxWidth > 600;
                                return GridView.count(
                                  crossAxisCount: isWide ? 2 : 1,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 3.5, // Adjust aspect ratio for cards
                                  children: [
                                    PaymentMethodCard(
                                      label: 'QRIS',
                                      icon: Icons.qr_code_2,
                                      isSelected: _selectedMethod == 'QRIS',
                                      onTap: () => setState(() => _selectedMethod = 'QRIS'),
                                    ),
                                    PaymentMethodCard(
                                      label: 'Tunai',
                                      icon: Icons.payments,
                                      isSelected: _selectedMethod == 'Tunai',
                                      onTap: () => setState(() => _selectedMethod = 'Tunai'),
                                    ),
                                    PaymentMethodCard(
                                      label: 'Kartu Kredit/Debit',
                                      icon: Icons.credit_card,
                                      isSelected: _selectedMethod == 'Kartu Kredit/Debit',
                                      onTap: () => setState(() => _selectedMethod = 'Kartu Kredit/Debit'),
                                    ),
                                    PaymentMethodCard(
                                      label: 'E-Wallet',
                                      icon: Icons.account_balance_wallet,
                                      isSelected: _selectedMethod == 'E-Wallet',
                                      onTap: () => setState(() => _selectedMethod = 'E-Wallet'),
                                    ),
                                    PaymentMethodCard(
                                      label: 'Transfer Bank',
                                      icon: Icons.account_balance,
                                      isSelected: _selectedMethod == 'Transfer Bank',
                                      onTap: () => setState(() => _selectedMethod = 'Transfer Bank'),
                                      isFullWidth: true,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // CTA Button
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundLight.withAlpha(204),
                border: const Border(top: BorderSide(color: Colors.black12)),
              ),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 672),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60, // py-4 approx
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _processPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Konfirmasi Pembayaran',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
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
