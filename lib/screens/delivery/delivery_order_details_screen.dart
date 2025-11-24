import 'package:flutter/material.dart';

class DeliveryOrderDetailsScreen extends StatelessWidget {
  const DeliveryOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Text(
              '#GRF-12095',
              style: TextStyle(
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Order Details (3/5 width)
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      // Order Items Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Item Pesanan',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 24),
                            _buildOrderItem(
                              name: '2x Ramen Pedas',
                              price: 'Rp 240.000',
                              details: 'Tambah cabai, Tanpa telur',
                            ),
                            const Divider(height: 32),
                            _buildOrderItem(
                              name: '1x Gyoza (6 pcs)',
                              price: 'Rp 80.000',
                            ),
                            const Divider(height: 32),
                            _buildOrderItem(
                              name: '1x Teh Hijau',
                              price: 'Rp 30.000',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Customer & Special Requests
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Pelanggan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 16),
                                  _buildIconText(Icons.person, 'Jane Doe'),
                                  const SizedBox(height: 12),
                                  _buildIconText(Icons.phone, '+1 (555) 123-4567'),
                                  const SizedBox(height: 12),
                                  _buildIconText(Icons.home, '123 Maple Street, Apt 4B,\nSpringfield, SP 67890'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Permintaan Khusus', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEC107).withAlpha(26), // accent-yellow-bg
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      '"Mohon sediakan serbet dan sumpit ekstra. Alergi ringan terhadap kacang, harap berhati-hati."',
                                      style: TextStyle(color: Color(0xFFB38600)), // darker yellow
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Totals Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: [
                            _buildTotalRow('Subtotal', 'Rp 350.000'),
                            const SizedBox(height: 8),
                            _buildTotalRow('Pajak & Biaya', 'Rp 45.000'),
                            const SizedBox(height: 8),
                            _buildTotalRow('Biaya Pengiriman', 'Rp 50.000'),
                            const Divider(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Total Keseluruhan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                Text('Rp 445.000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem({required String name, required String price, String? details}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.fastfood, color: Colors.grey),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              Text(price, style: const TextStyle(color: Color(0xFF4C9A66), fontSize: 16)),
              if (details != null)
                Text(details, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
      ],
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
