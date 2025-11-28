import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'widgets/menu_item_card.dart';
import '../../services/api_service.dart';
import '../../models/product_model.dart';
import 'package:intl/intl.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  String _selectedCategory = 'Pembuka';
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _productsFuture = _apiService.getProducts(search: _searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;
          final gridCrossAxisCount = constraints.maxWidth < 600 ? 1 : (constraints.maxWidth < 1100 ? 2 : 3);
          final gridChildAspectRatio = constraints.maxWidth < 600 ? 1.2 : 0.8;

          if (isMobile) {
            return Column(
              children: [
                // Mobile Category Selector (Horizontal List)
                Container(
                  height: 60,
                  color: Colors.white,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    children: [
                      _buildMobileCategoryChip('Pembuka', true),
                      const SizedBox(width: 8),
                      _buildMobileCategoryChip('Hidangan Utama', false),
                      const SizedBox(width: 8),
                      _buildMobileCategoryChip('Pencuci Mulut', false),
                      const SizedBox(width: 8),
                      _buildMobileCategoryChip('Minuman', false),
                    ],
                  ),
                ),
                const Divider(height: 1),
                // Menu Grid
                Expanded(
                  child: FutureBuilder<List<Product>>(
                    future: _productsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Tidak ada produk'));
                      }

                      final products = snapshot.data!;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: gridCrossAxisCount,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: gridChildAspectRatio,
                        ),
                        padding: const EdgeInsets.all(16),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return MenuItemCard(
                            name: product.name,
                            description: product.description ?? '',
                            price: _formatCurrency(product.price),
                            isAvailable: product.stock > 0,
                            onEdit: () => _showAddItemDialog(context),
                            onAvailabilityChanged: (val) {
                              // TODO: Implement update stock/availability via API
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }

          // Desktop Layout
          return Row(
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
                                  hintText: 'Cari produk...',
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (value) {
                                  _loadProducts();
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: _loadProducts,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: FutureBuilder<List<Product>>(
                          future: _productsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(child: Text('Tidak ada produk'));
                            }

                            final products = snapshot.data!;
                            return GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 24,
                                crossAxisSpacing: 24,
                                childAspectRatio: 1.2,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return MenuItemCard(
                                  name: product.name,
                                  description: product.description ?? '',
                                  price: _formatCurrency(product.price),
                                  isAvailable: product.stock > 0,
                                  onEdit: () => _showAddItemDialog(context),
                                  onAvailabilityChanged: (val) {
                                     // TODO: Implement update stock/availability via API
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMobileCategoryChip(String title, bool isSelected) {
    return ChoiceChip(
      label: Text(title),
      selected: isSelected,
      onSelected: (bool selected) {},
      selectedColor: AppColors.primary.withAlpha(51),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: Colors.white,
      side: BorderSide(
        color: isSelected ? AppColors.primary : Colors.grey[300]!,
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
