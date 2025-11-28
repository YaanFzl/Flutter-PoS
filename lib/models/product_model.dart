class Product {
  final int id;
  final String name;
  final int price;
  final String? description;
  final String? image;
  final String category;
  final int stock;
  final List<ProductVariant> variants;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.image,
    required this.category,
    required this.stock,
    this.variants = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Helper to safely parse int
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    String? imageLink;
    if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      final firstImage = (json['images'] as List).first;
      if (firstImage is Map && firstImage['imageLink'] != null) {
        imageLink = firstImage['imageLink'];
      }
    }

    return Product(
      id: parseInt(json['id']),
      name: json['name'] ?? '',
      price: parseInt(json['price']),
      description: json['description'],
      image: imageLink ?? json['image'], // Fallback to 'image' if 'images' array is missing/empty
      category: json['category'] ?? '',
      stock: parseInt(json['stock']),
      variants: (json['variants'] as List<dynamic>?)
              ?.map((v) => ProductVariant.fromJson(v))
              .toList() ??
          [],
    );
  }
}

class ProductVariant {
  final int id;
  final int productId;
  final String name;
  final int price;
  final int stock;

  ProductVariant({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.stock,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    // Helper to safely parse int
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return ProductVariant(
      id: parseInt(json['id']),
      productId: parseInt(json['id_product']),
      name: json['name'] ?? '',
      price: parseInt(json['price']),
      stock: parseInt(json['stock']),
    );
  }
}
