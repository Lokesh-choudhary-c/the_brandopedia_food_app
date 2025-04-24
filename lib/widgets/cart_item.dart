import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_brainopedia_food_app/providers/cart_providers.dart';
import '../models/food_item.dart';


class CartItemTile extends StatelessWidget {
  final FoodItem item;
  final int quantity;

  const CartItemTile({super.key, required this.item, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return ListTile(
      leading: Image.asset(item.imagePath, width: 50, height: 50),
      title: Text(item.name),
      subtitle: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => cart.removeFromCart(item),
          ),
          Text(quantity.toString()),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => cart.addToCart(item),
          ),
        ],
      ),
      trailing: Text('₹ ${item.price * quantity}',
    style: const TextStyle(fontWeight: FontWeight.bold)),

    );
  }
}
