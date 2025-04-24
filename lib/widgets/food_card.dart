import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_brainopedia_food_app/models/food_item.dart';
import 'package:the_brainopedia_food_app/providers/cart_providers.dart';
import 'package:the_brainopedia_food_app/providers/favourite_providers.dart';

class FoodCard extends StatelessWidget {
  final FoodItem item;

  const FoodCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final favProv = context.watch<FavoriteProvider>();
    final qty = cart.cartItems[item] ?? 0;
    final isFav = favProv.isFavorite(item);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {}, 
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(item.imagePath,
                      width: 120, height: 120, fit: BoxFit.cover),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("₹ ${item.price}",
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder: (child, anim) =>
                            FadeTransition(opacity: anim, child: child),
                        child: qty == 0
                            ? ElevatedButton(
                                key: const ValueKey('add_btn'),
                                onPressed: () => cart.addToCart(item),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5A2FC3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: const Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              )
                            : Row(
                                key: ValueKey<int>(qty),
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      iconSize: 20,
                                      icon: const Icon(Icons.remove),
                                      color: const Color(0xFF5A2FC3),
                                      onPressed: () =>
                                          cart.removeFromCart(item),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(qty.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      iconSize: 20,
                                      icon: const Icon(Icons.add),
                                      color: const Color(0xFF5A2FC3),
                                      onPressed: () => cart.addToCart(item),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: IconButton(
                    key: ValueKey<bool>(isFav),
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? const Color(0xFF5A2FC3) : Colors.grey,
                    ),
                    onPressed: () => favProv.toggleFavorite(item),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



