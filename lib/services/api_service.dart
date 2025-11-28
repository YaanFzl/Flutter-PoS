import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/transaction_model.dart';

class ApiService {
  static const String baseUrl = 'https://pos-app-backend-production.up.railway.app';

  Future<User> login(String email, String password) async {
    // Hardcoded login for testing/fallback
    if (email == '1' && password == '1') {
      final user = User(
        token: 'mock_token_12345',
        email: email,
        role: 'admin',
      );
      await _saveToken(user.token);
      return user;
    }

    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      await _saveToken(user.token);
      return user;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Future<String?> _getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('auth_token');
  // }

  Future<List<Product>> getProducts({int page = 1, int rowsPerPage = 10, String? search}) async {
    String query = 'page=$page&rowsPerPage=$rowsPerPage';
    if (search != null && search.isNotEmpty) {
      query += '&search=$search';
    }

    final response = await http.get(Uri.parse('$baseUrl/api/products?$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> productsJson = data['data'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Transaction>> getTransactions({int page = 1, int rowsPerPage = 10, String? status}) async {
    String query = 'page=$page&rowsPerPage=$rowsPerPage';
    if (status != null && status.isNotEmpty) {
      query += '&status=$status';
    }

    final response = await http.get(Uri.parse('$baseUrl/api/transactions?$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> transactionsJson = data['data'];
      return transactionsJson.map((json) => Transaction.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<void> createTransaction(Map<String, dynamic> transactionData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/transactions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(transactionData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create transaction: ${response.body}');
    }
  }

  Future<void> updateTransaction(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/transactions/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update transaction: ${response.body}');
    }
  }
}
