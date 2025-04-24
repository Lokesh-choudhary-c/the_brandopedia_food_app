import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_brainopedia_food_app/models/food_item.dart';
import 'package:the_brainopedia_food_app/providers/favourite_providers.dart';
import 'package:the_brainopedia_food_app/widgets/food_card.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  final List<FoodItem> allItems;

  const CategoryScreen({
    super.key,
    required this.category,
    required this.allItems,
  });

  @override
  Widget build(BuildContext context) {
    List<FoodItem> displayItems;

    if (category.toLowerCase() == 'favorites') {
      final favoriteProvider = context.watch<FavoriteProvider>();
      displayItems = favoriteProvider.favorites.toList();
    } else {
      displayItems = allItems.where((item) {
        return item.category.toLowerCase() == category.toLowerCase();
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5A2FC3),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: displayItems.isNotEmpty
            ? displayItems.map((item) => FoodCard(item: item)).toList()
            : [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text("No items found in this category."),
                  ),
                )
              ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF5A2FC3),
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/cart');
          } else if (index == 2) {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: "Profile",
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation, secondaryAnimation) {
                return const SizedBox(); 
              },
              transitionBuilder: (context, animation, secondaryAnimation, child) {
                final curvedValue = Curves.easeInOut.transform(animation.value);
                return Transform.translate(
                  offset: Offset((1 - curvedValue) * MediaQuery.of(context).size.width * 0.5, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            right: 20,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.black),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
