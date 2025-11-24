import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'menu/widgets/menu_item_card.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  String _selectedCategory = 'Pembuka';
  final TextEditingController _searchController = TextEditingController();
  
  // Sample state for menu items availability
  final Map<String, bool> _itemAvailability = {
    'Bruschetta': true,
    'Spring Rolls': true,
    'Sup Tomat': true,
    'Salad Caesar': true,
  };

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
                        MenuItemCard(
                          name: 'Bruschetta',
                          description: 'Roti panggang dengan tomat, bawang putih, dan basil.',
                          price: 'Rp 85.000',
                          isAvailable: _itemAvailability['Bruschetta'] ?? true,
                          onEdit: () => _showAddItemDialog(context),
                          onAvailabilityChanged: (val) {
                            setState(() {
                              _itemAvailability['Bruschetta'] = val;
                            });
                          },
                        ),
                        MenuItemCard(
                          name: 'Spring Rolls',
                          description: 'Lumpia goreng dengan sayuran segar.',
                          price: 'Rp 75.000',
                          isAvailable: _itemAvailability['Spring Rolls'] ?? true,
                          onEdit: () => _showAddItemDialog(context),
                          onAvailabilityChanged: (val) {
                            setState(() {
                              _itemAvailability['Spring Rolls'] = val;
                            });
                          },
                        ),
                        MenuItemCard(
                          name: 'Sup Tomat',
                          description: 'Sup tomat segar dengan rempah Italia.',
                          price: 'Rp 55.000',
                          isAvailable: _itemAvailability['Sup Tomat'] ?? true,
                          onEdit: () => _showAddItemDialog(context),
                          onAvailabilityChanged: (val) {
                            setState(() {
                              _itemAvailability['Sup Tomat'] = val;
                            });
                          },
                        ),
                        MenuItemCard(
                          name: 'Salad Caesar',
                          description: 'Salad klasik dengan dressing Caesar.',
                          price: 'Rp 95.000',
                          isAvailable: _itemAvailability['Salad Caesar'] ?? true,
                          onEdit: () => _showAddItemDialog(context),
                          onAvailabilityChanged: (val) {
                            setState(() {
                              _itemAvailability['Salad Caesar'] = val;
                            });
                          },
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
