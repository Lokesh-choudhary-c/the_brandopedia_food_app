import 'package:flutter/material.dart';
import 'package:the_brainopedia_food_app/screens/category_screen.dart';
import 'package:the_brainopedia_food_app/screens/offers_screen.dart';
import 'package:the_brainopedia_food_app/screens/profile_screen.dart';
import 'package:the_brainopedia_food_app/widgets/promo_card.dart';
import '../models/food_item.dart';
import '../widgets/food_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late List<FoodItem> _filteredItems;

  late AnimationController _animController;
  late Animation<double> _searchAnim,
      _categoryAnim,
      _promoAnim,
      _exploreAnim;

  final List<FoodItem> _allItems = [
  FoodItem(name: "Margherita Pizza", price: 150, imagePath: "assets/images/brandopedia_pizza.jpg", category: "Food"),
  FoodItem(name: "Burger", price: 120, imagePath: "assets/images/brandopedia_burger.jpg", category: "Food"),
  FoodItem(name: "Gulab Jamun", price: 80, imagePath: "assets/images/brandpoedia_gulab.jpg", category: "Food"),
  FoodItem(name: "Fries", price: 90, imagePath: "assets/images/brandopedia_fries.jpg", category: "Food"),
  FoodItem(name: "Pasta", price: 130, imagePath: "assets/images/brandopedia_pasta.jpg", category: "Food"),
  FoodItem(name: "Dosa", price: 70, imagePath: "assets/images/brandopedia_dosa.jpg", category: "Food"),
  FoodItem(name: "Idli", price: 50, imagePath: "assets/images/brandopedia_idli.jpg", category: "Food"),
  FoodItem(name: "Samosa", price: 40, imagePath: "assets/images/brandpoedia_samosa.jpg", category: "Food"),
  FoodItem(name: "Ice Cream", price: 60, imagePath: "assets/images/brandopedia_icecream.jpg", category: "Food"),
  FoodItem(name: "MilkShake", price: 90, imagePath: "assets/images/brandopedia_milkshake.jpg", category: "Beverages"),
  FoodItem(name: "Pani Puri", price: 60, imagePath: "assets/images/brandopedia_panipuri.jpg", category: "Food"),
  FoodItem(name: "Coke", price: 50, imagePath: "assets/images/coke.jpg", category: "Beverages"),
];

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_allItems);
    _searchController.addListener(_onSearchChanged);

    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _searchAnim = CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn));
    _categoryAnim = CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.2, 0.4, curve: Curves.easeIn));
    _promoAnim = CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 0.6, curve: Curves.easeIn));
    _exploreAnim = CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn));

    _animController.forward();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredItems = List.from(_allItems);
      } else {
        _filteredItems = _allItems
            .where((item) => item.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Chennai",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle,
                color: Color(0xFF5A2FC3), size: 40),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) =>ProfileScreen()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            FadeTransition(
              opacity: _searchAnim,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search for restaurants or dishes",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            FadeTransition(
              opacity: _categoryAnim,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navButton(Icons.fastfood, "Food", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CategoryScreen(
                                category: 'Food', allItems: _allItems)));
                  }),
                  _navButton(Icons.local_drink, "Beverages", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CategoryScreen(
                                category: 'Beverages', allItems: _allItems)));
                  }),
                  _navButton(Icons.check_circle, "Offers", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const OffersScreen()));
                  }),
                  _navButton(Icons.favorite, "Favorites", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CategoryScreen(
                                category: 'Favorites',
                                allItems: _allItems)));
                  }),
                ],
              ),
            ),
            const SizedBox(height: 15),
            FadeTransition(
              opacity: _promoAnim,
              child: Row(
                children: [
                  Expanded(
                    child: PromoCardLarge(
                      category: 'Food',
                      discount: '30% OFF',
                      subtitle: 'UP 10.175',
                      buttonLabel: 'ORDER NOW',
                      imagePath: 'assets/images/burger.png',
                      backgroundColor: const Color.fromARGB(255, 204, 81, 1),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: const [
                        SizedBox(
                          width: double.infinity,
                          child: PromoCardSmall(
                            discount: '30% OFF',
                            subtitle: 'TRY IT NOW',
                            backgroundColor: Color.fromARGB(255, 0, 51, 114),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: PromoCardSmall(
                            discount: '50% OFF',
                            subtitle: 'USE 302406',
                            backgroundColor: Color.fromARGB(255, 161, 77, 2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            FadeTransition(
              opacity: _exploreAnim,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text("Explore",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  ..._filteredItems
                      .map((item) => FoodCard(item: item))
                      ,
                  if (_filteredItems.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child:
                          Center(child: Text("No items match your search.")),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF3ECFF),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: const Color(0xFF5A2FC3)),
          ),
          const SizedBox(height: 6),
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
