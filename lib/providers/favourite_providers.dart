import 'package:flutter/material.dart';
import '../models/food_item.dart';

class FavoriteProvider with ChangeNotifier {
  final Set<FoodItem> _favorites = {};

  Set<FoodItem> get favorites => _favorites;

  void toggleFavorite(FoodItem item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
    } else {
      _favorites.add(item);
    }
    notifyListeners();
  }

  bool isFavorite(FoodItem item) => _favorites.contains(item);
}
