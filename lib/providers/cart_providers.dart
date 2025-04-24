import 'package:flutter/material.dart';
import 'package:the_brainopedia_food_app/database/db_helper.dart';
import '../models/food_item.dart';

class CartProvider extends ChangeNotifier {
  final Map<FoodItem, int> cartItems = {}; 
  final _dbHelper = CartDBHelper(); 

  Future<void> loadCart() async {
    final data = await _dbHelper.getCartItems();
    cartItems.clear();

    for (var item in data) {
      cartItems[FoodItem(
        name: item['name'],
        price: item['price'],
        imagePath: item['imagePath'],
        category: item['category'] ?? 'Unknown',
      )] = item['quantity'] ?? 1;
    }

    notifyListeners();
  }

  void addToCart(FoodItem item) async {
    final currentQty = cartItems[item] ?? 0;
    final newQty = currentQty + 1;

    cartItems[item] = newQty;

    await _dbHelper.insertItem({
      'name': item.name,
      'price': item.price,
      'imagePath': item.imagePath,
      'category': item.category,
      'quantity': newQty,
    });

    notifyListeners();
  }

  void removeFromCart(FoodItem item) async {
    final quantity = cartItems[item];
    if (quantity == null) return;

    if (quantity > 1) {
      cartItems[item] = quantity - 1;
      await _dbHelper.updateQuantity(item.name, quantity - 1);
    } else {
      cartItems.remove(item);
      await _dbHelper.deleteItem(item.name);
    }

    notifyListeners();
  }

  void clearCart() async {
    cartItems.clear();
    await _dbHelper.clearCart();
    notifyListeners();
  }

  int getTotalPrice() {
    int total = 0;
    cartItems.forEach((item, qty) {
      total += (item.price * qty).toInt();
    });
    return total;
  }

  int getQuantity(FoodItem item) {
    return cartItems[item] ?? 0;
  }
}
