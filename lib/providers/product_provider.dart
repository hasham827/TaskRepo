import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task/models/product.dart';
import 'package:task/services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  Map<String, List<Product>> _productsByCategory = {};
  bool _isLoading = false;
  String? _error;

  Map<String, List<Product>> get productsByCategory => _productsByCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getRequest(
        endpoint: '/products',
        chat: false, // Use baseUrl[](https://fakestoreapi.com)
      );

      if (response != null && response.statusCode == 200) {
        log("Here is the Product Response :::: ${response.body}");
        final data = json.decode(response.body) as List;
        final products = data.map((json) => Product.fromJson(json)).toList();

        // Group products by category
        _productsByCategory = {};
        for (var product in products) {
          final category = product.category ?? 'Uncategorized';
          if (!_productsByCategory.containsKey(category)) {
            _productsByCategory[category] = [];
          }
          _productsByCategory[category]!.add(product);
        }

        // Sort products within each category (e.g., by price ascending)
        _productsByCategory.forEach((category, products) {
          products.sort((a, b) => a.price.compareTo(b.price)); // Sort by price
          // Alternative: Sort by title
          // products.sort((a, b) => a.title.compareTo(b.title));
          // If using MeiliSearch priority:
          // products.sort((a, b) => (b.priority ?? 0).compareTo(a.priority ?? 0));
        });
      } else {
        _error = 'Failed to load products';
      }
    } catch (e) {
      _error = 'Error fetching products: $e';
      log('Error fetching products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
