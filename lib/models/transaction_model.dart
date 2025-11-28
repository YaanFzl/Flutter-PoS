class Transaction {
  final int id;
  final int idCashier;
  final String type;
  final int? tableNumber;
  final String? customerName;
  final String? customerEmail;
  final String paymentMethod;
  final String status;
  final int totalPrice;
  final String createdAt;
  final List<TransactionItem> items;

  Transaction({
    required this.id,
    required this.idCashier,
    required this.type,
    this.tableNumber,
    this.customerName,
    this.customerEmail,
    required this.paymentMethod,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.items,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    // Helper to safely parse int
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    var itemsList = (json['transactionDetails'] as List<dynamic>?)
            ?.map((item) => TransactionItem.fromJson(item))
            .toList() ?? [];

    int calculatedTotal = 0;
    if (json['totalPrice'] == null) {
       for (var item in itemsList) {
         calculatedTotal += item.subtotal;
       }
    } else {
      calculatedTotal = parseInt(json['totalPrice']);
    }

    return Transaction(
      id: parseInt(json['id']),
      idCashier: parseInt(json['idCashier']),
      type: json['type'] ?? '',
      tableNumber: json['tableNumber'] != null ? parseInt(json['tableNumber']) : null,
      customerName: json['customerName'],
      customerEmail: json['customerEmail'],
      paymentMethod: json['paymentMethod'] ?? '',
      status: json['status'] ?? '',
      totalPrice: calculatedTotal,
      createdAt: json['createdAt'] ?? '',
      items: itemsList,
    );
  }
}

class TransactionItem {
  final int id;
  final int idTransaction;
  final int? idProduct;
  final int? idProductVariant;
  final String productName;
  final String? variantName;
  final int price;
  final int quantity;
  final int subtotal;

  TransactionItem({
    required this.id,
    required this.idTransaction,
    this.idProduct,
    this.idProductVariant,
    required this.productName,
    this.variantName,
    required this.price,
    required this.quantity,
    required this.subtotal,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    // Helper to safely parse int
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    int qty = parseInt(json['quantity']);
    if (qty == 0) qty = 1; // Default to 1 if missing or 0
    
    int price = parseInt(json['price']);
    int subtotal = parseInt(json['subtotal']);
    
    if (subtotal == 0 && price > 0) {
      subtotal = price * qty;
    }

    return TransactionItem(
      id: parseInt(json['id']),
      idTransaction: parseInt(json['idTransaction']),
      idProduct: json['idProduct'] != null ? parseInt(json['idProduct']) : null,
      idProductVariant: json['idProductVarian'] != null ? parseInt(json['idProductVarian']) : null,
      productName: json['product']?['name'] ?? json['productName'] ?? 'Product #${json['idProduct']}',
      variantName: json['variantName'],
      price: price,
      quantity: qty,
      subtotal: subtotal,
    );
  }
}
