import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  List<int> _favoriteIds = [];

  List<int> get favoriteIds => _favoriteIds;

  FavoriteProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteData = prefs.getString('favorites');
    if (favoriteData != null) {
      _favoriteIds = List<int>.from(json.decode(favoriteData));
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(int productId) async {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites', json.encode(_favoriteIds));
  }

  bool isFavorite(int productId) => _favoriteIds.contains(productId);
}
