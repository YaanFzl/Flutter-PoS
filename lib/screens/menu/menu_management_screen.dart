import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  String _selectedCategory = 'Pembuka';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8F6),
        elevation: 0,
        title: const Text(
          'Manajemen Menu',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.black12),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: ElevatedButton.icon(
              onPressed: () {
                _showAddItemDialog(context);
              },
              icon: const Icon(Icons.add),
              label: const Text('Tambah Item Baru'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 300,
            decoration: const BoxDecoration(
              color: Color(0xFFF6F8F6),
              border: Border(right: BorderSide(color: Colors.black12)),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kategori',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                _buildCategoryItem('Pembuka', Icons.local_bar),
                _buildCategoryItem('Hidangan Utama', Icons.restaurant_menu),
                _buildCategoryItem('Pencuci Mulut', Icons.icecream),
                _buildCategoryItem('Minuman', Icons.emoji_food_beverage),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: 'Cari pembuka...',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                      childAspectRatio: 1.2,
                      children: [
                        _buildMenuItem(
                          name: 'Bruschetta',
                          description: 'Roti panggang dengan tomat, bawang putih, dan basil.',
                          price: 'Rp 85.000',
                          isAvailable: true,
                        ),
                        _buildMenuItem(
                          name: 'Saus Bayam',
                          description: 'Saus krim dengan artichoke dan bayam.',
                          price: 'Rp 100.000',
                          isAvailable: true,
                        ),
                        _buildMenuItem(
                          name: 'Calamari',
                          description: 'Cumi goreng ringan dengan saus marinara.',
                          price: 'Rp 120.000',
                          isAvailable: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String label, IconData icon) {
    final isSelected = _selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = label;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withAlpha(51) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.black87 : Colors.grey.shade600,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.black87 : Colors.grey.shade600,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String name,
    required String description,
    required String price,
    required bool isAvailable,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8F6),
        borderRadius: BorderRadius.circular(12),
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
                      Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(description, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                    ],
                  ),
                ),
                Text(price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(val ? 'Item tersedia' : 'Item tidak tersedia'),
                            backgroundColor: const Color(0xFF13EC5B),
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      thumbColor: WidgetStateProperty.all(isAvailable ? AppColors.primary : Colors.grey),
                      trackColor: WidgetStateProperty.all(isAvailable ? AppColors.primary.withAlpha(77) : Colors.grey.shade300),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    _showAddItemDialog(context);
                  },
                  icon: const Icon(Icons.edit, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 672,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tambah Item Baru', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nama Item',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. Bruschetta',
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan deskripsi singkat',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Harga',
                        border: OutlineInputBorder(),
                        prefixText: 'Rp ',
                        hintText: '0.00',
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Kategori',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Ketersediaan', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 16),
                      const Text('Tersedia'),
                      Switch(
                        value: true,
                        onChanged: (val) {},
                        thumbColor: WidgetStateProperty.all(AppColors.primary),
                        trackColor: WidgetStateProperty.all(AppColors.primary.withAlpha(77)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Batal'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Item berhasil disimpan'),
                          backgroundColor: Color(0xFF13EC5B),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
