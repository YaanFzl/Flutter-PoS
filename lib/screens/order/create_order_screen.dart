import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/product_model.dart';
import 'widgets/product_selection_card.dart';
import 'widgets/cart_summary_widget.dart';
import 'package:intl/intl.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  
  late Future<List<Product>> _productsFuture;
  final Map<Product, int> _cart = {};
  bool _isSubmitting = false;

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

  void _addToCart(Product product) {
    setState(() {
      if (_cart.containsKey(product)) {
        _cart[product] = _cart[product]! + 1;
      } else {
        _cart[product] = 1;
      }
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      if (_cart.containsKey(product)) {
        if (_cart[product]! > 1) {
          _cart[product] = _cart[product]! - 1;
        } else {
          _cart.remove(product);
        }
      }
    });
  }

  Future<void> _submitOrder(String customerName, String tableNumber, String paymentMethod, String orderType) async {
    setState(() => _isSubmitting = true);

    try {
      final items = _cart.entries.map((entry) {
        return {
          'id_product': entry.key.id,
          'quantity': entry.value,
          'price': entry.key.price,
        };
      }).toList();

      final type = orderType == 'Makan Ditempat' ? 'makan_ditempat' : 'bawa_pulang';
      
      final transactionData = {
        'id_cashier': 1, // Default or from session
        'customer_name': customerName,
        'payment_method': paymentMethod,
        'type': type,
        'items': items,
      };

      if (type == 'makan_ditempat' && tableNumber.isNotEmpty) {
        transactionData['table_number'] = int.parse(tableNumber);
      }

      await _apiService.createTransaction(transactionData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pesanan berhasil dibuat!'),
            backgroundColor: Color(0xFF13EC5B),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context, true); // Return true to refresh dashboard
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membuat pesanan: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Buat Pesanan Baru',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.black12),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;

          if (isDesktop) {
            return Row(
              children: [
                // Product Grid (Left)
                Expanded(
                  flex: 7,
                  child: _buildProductSection(),
                ),
                // Cart Sidebar (Right)
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: const Border(left: BorderSide(color: Colors.black12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 10,
                        offset: const Offset(-4, 0),
                      ),
                    ],
                  ),
                  child: CartSummaryWidget(
                    cartItems: _cart,
                    onIncrement: _addToCart,
                    onDecrement: _removeFromCart,
                    onSubmit: _submitOrder,
                    isLoading: _isSubmitting,
                  ),
                ),
              ],
            );
          }

          // Mobile Layout
          return Stack(
            children: [
              _buildProductSection(paddingBottom: 100), // Add padding for bottom sheet
              // Bottom Sheet Cart
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 20,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_cart.length} Item',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Container(
                                  height: MediaQuery.of(context).size.height * 0.8,
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF6F8F6),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                  ),
                                  child: CartSummaryWidget(
                                    cartItems: _cart,
                                    onIncrement: _addToCart,
                                    onDecrement: _removeFromCart,
                                    onSubmit: _submitOrder,
                                    isLoading: _isSubmitting,
                                  ),
                                ),
                              );
                            },
                            child: const Text('Lihat Keranjang'),
                          ),
                        ],
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

  Widget _buildProductSection({double paddingBottom = 0}) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
                    onSubmitted: (value) => _loadProducts(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _loadProducts,
                ),
              ],
            ),
          ),
        ),
        // Grid
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
                padding: EdgeInsets.fromLTRB(24, 0, 24, 24 + paddingBottom),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductSelectionCard(
                    name: product.name,
                    price: _formatCurrency(product.price),
                    imageUrl: product.image,
                    onTap: () => _addToCart(product),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
