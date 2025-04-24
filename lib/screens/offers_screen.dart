import 'package:flutter/material.dart';
import 'package:the_brainopedia_food_app/screens/home_screen.dart';
import 'package:the_brainopedia_food_app/screens/cart_screen.dart';
import 'package:the_brainopedia_food_app/screens/profile_screen.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> offerBanners = [
      'assets/images/offer 2.jpg',
      'assets/images/offer 1.jpg',
      'assets/images/ofeer 3.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF5A2FC3),
      ),
      body: ListView.builder(
        itemCount: offerBanners.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                offerBanners[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF5A2FC3),
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
