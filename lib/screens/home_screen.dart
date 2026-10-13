import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import '../models/cart_item.dart';
import '../models/cart_manager.dart';
import '../models/favorite_manager.dart';
import 'food_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";
  String selectedCategory = "All";
  int selectedIndex = 0;

  final List<String> categories = [
    "All",
    "Burger",
    "Pizza",
    "Pasta",
    "Biryani",
    "Andhra",
    "Snacks",
    "Dessert",
  ];

  final List<Map<String, dynamic>> foods = [
    {
      "image": "assets/images/i1.jpg",
      "name": "Cheese Burger",
      "description":
          "Juicy grilled burger with melted cheese, fresh vegetables and creamy signature sauce.",
      "price": "₹199",
      "priceValue": 199.0,
      "rating": "4.8",
      "category": "Burger",
      "type": "Non-Veg",
      "spicy": "🌶️ Mild",
      "time": "15-20 min",
      "calories": "520 kcal",
    },
    {
      "image": "assets/images/i2.jpg",
      "name": "Italian Pizza",
      "description":
          "Italian-style pizza with tomato sauce, mozzarella cheese, fresh vegetables and herbs.",
      "price": "₹299",
      "priceValue": 299.0,
      "rating": "4.7",
      "category": "Pizza",
      "type": "Veg",
      "spicy": "🌶️ Mild",
      "time": "20-25 min",
      "calories": "680 kcal",
    },
    {
      "image": "assets/images/i3.jpg",
      "name": "Creamy Pasta",
      "description":
          "Creamy white sauce pasta prepared with fresh vegetables, herbs and parmesan cheese.",
      "price": "₹249",
      "priceValue": 249.0,
      "rating": "4.6",
      "category": "Pasta",
      "type": "Veg",
      "spicy": "🌶️ Mild",
      "time": "15-20 min",
      "calories": "590 kcal",
    },
    {
      "image": "assets/images/i4.jpg",
      "name": "Chicken Biryani",
      "description":
          "Fragrant basmati rice cooked with tender chicken, fried onions, mint and traditional spices.",
      "price": "₹299",
      "priceValue": 299.0,
      "rating": "4.9",
      "category": "Biryani",
      "type": "Non-Veg",
      "spicy": "🌶️🌶️ Medium",
      "time": "30-35 min",
      "calories": "720 kcal",
    },
    {
      "image": "assets/images/i5.jpg",
      "name": "Guntur Chicken",
      "description":
          "Spicy Andhra-style chicken prepared with green chillies, red chilli, curry leaves and spices.",
      "price": "₹279",
      "priceValue": 279.0,
      "rating": "4.8",
      "category": "Andhra",
      "type": "Non-Veg",
      "spicy": "🌶️🌶️🌶️ Hot",
      "time": "25-30 min",
      "calories": "610 kcal",
    },
    {
      "image": "assets/images/i6.jpg",
      "name": "Gongura Mutton",
      "description":
          "Tender mutton cooked with tangy Gongura leaves, onions, garlic and authentic Andhra spices.",
      "price": "₹349",
      "priceValue": 349.0,
      "rating": "4.9",
      "category": "Andhra",
      "type": "Non-Veg",
      "spicy": "🌶️🌶️🌶️ Hot",
      "time": "40-45 min",
      "calories": "760 kcal",
    },
    {
      "image": "assets/images/i7.jpg",
      "name": "Andhra Chicken Biryani",
      "description":
          "Spicy Andhra biryani prepared with fragrant rice, chicken, green chillies and regional masalas.",
      "price": "₹329",
      "priceValue": 329.0,
      "rating": "4.8",
      "category": "Biryani",
      "type": "Non-Veg",
      "spicy": "🌶️🌶️🌶️ Hot",
      "time": "35-40 min",
      "calories": "740 kcal",
    },
    {
      "image": "assets/images/i8.jpg",
      "name": "Pesarattu",
      "description":
          "Traditional Andhra green gram dosa served hot with ginger chutney and upma.",
      "price": "₹129",
      "priceValue": 129.0,
      "rating": "4.7",
      "category": "Andhra",
      "type": "Veg",
      "spicy": "🌶️ Medium",
      "time": "15-20 min",
      "calories": "320 kcal",
    },
    {
      "image": "assets/images/i9.jpg",
      "name": "Punugulu",
      "description":
          "Crispy golden Andhra fritters made from fermented rice and urad dal batter.",
      "price": "₹99",
      "priceValue": 99.0,
      "rating": "4.6",
      "category": "Snacks",
      "type": "Veg",
      "spicy": "🌶️ Medium",
      "time": "15 min",
      "calories": "290 kcal",
    },
    {
      "image": "assets/images/i10.jpg",
      "name": "Chicken 65",
      "description":
          "Crispy fried chicken pieces marinated with chilli, ginger, garlic, yogurt and spices.",
      "price": "₹229",
      "priceValue": 229.0,
      "rating": "4.7",
      "category": "Snacks",
      "type": "Non-Veg",
      "spicy": "🌶️🌶️ Medium",
      "time": "20-25 min",
      "calories": "480 kcal",
    },
    {
      "image": "assets/images/i11.jpg",
      "name": "Chocolate Cake",
      "description":
          "Rich and moist chocolate cake layered with smooth chocolate cream and chocolate glaze.",
      "price": "₹179",
      "priceValue": 179.0,
      "rating": "4.9",
      "category": "Dessert",
      "type": "Veg",
      "spicy": "No Spice",
      "time": "10 min",
      "calories": "430 kcal",
    },
    {
      "image": "assets/images/i12.jpg",
      "name": "Bobbatlu",
      "description":
          "Traditional Telugu sweet made with soft dough, chana dal, jaggery and cardamom.",
      "price": "₹119",
      "priceValue": 119.0,
      "rating": "4.8",
      "category": "Dessert",
      "type": "Veg",
      "spicy": "No Spice",
      "time": "15 min",
      "calories": "310 kcal",
    },
  ];

  List<Map<String, dynamic>> get filteredFoods {
    return foods.where((food) {
      final matchesCategory =
          selectedCategory == "All" ||
          food["category"] == selectedCategory;

      final matchesSearch = food["name"]
          .toString()
          .toLowerCase()
          .contains(searchText.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void addToCart(Map<String, dynamic> food) {
    CartManager.addItem(
      CartItem(
        image: food["image"],
        name: food["name"],
        price: food["price"],
        priceValue: food["priceValue"],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${food["name"]} added to cart 🛒"),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0D1117),
        elevation: 0,
        title: const Text(
          "Food Menu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ValueListenableBuilder<int>(
              valueListenable: CartManager.itemCount,
              builder: (context, count, _) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    if (count > 0)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text(
                            count > 99 ? "99+" : count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What would you like to eat?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Delicious food, delivered to you",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xffFFB75E), Color(0xffED8F03)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Flash Deal",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Get 15% off on your first order",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            "Use code: FRESH15",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.local_offer_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              onChanged: (value) {
                setState(() => searchText = value);
              },
              decoration: InputDecoration(
                hintText: "Search food...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xff171C22),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),
            const Text(
              "Categories",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedCategory = category);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.orange
                            : const Color(0xff171C22),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Popular Food",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${filteredFoods.length} items",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 15),

            if (filteredFoods.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    "No food found 😔",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredFoods.length,
                itemBuilder: (context, index) {
                  final food = filteredFoods[index];
                  final isFavorite =
                      FavoriteManager.isFavorite(food["name"]);

                  return FoodCard(
                    image: food["image"],
                    name: food["name"],
                    description: food["description"],
                    price: food["price"],
                    rating: food["rating"],
                    type: food["type"],
                    spicy: food["spicy"],
                    time: food["time"],
                    isFavorite: isFavorite,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodDetailsScreen(
                            image: food["image"],
                            name: food["name"],
                            description: food["description"],
                            price: food["price"],
                            rating: food["rating"],
                            type: food["type"],
                            spicy: food["spicy"],
                            time: food["time"],
                            calories: food["calories"],
                          ),
                        ),
                      );
                    },
                    onAdd: () => addToCart(food),
                    onFavorite: () {
                      FavoriteManager.toggleFavorite(
                        CartItem(
                          image: food["image"],
                          name: food["name"],
                          price: food["price"],
                          priceValue: food["priceValue"],
                        ),
                      );
                      setState(() {});
                    },
                  );
                },
              ),
          ],
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: CartManager.itemCount,
        builder: (context, count, _) {
          return BottomNavigationBar(
            currentIndex: selectedIndex,
            backgroundColor: const Color(0xff171C22),
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              if (index == 0) {
                setState(() => selectedIndex = 0);
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              }
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    if (count > 0)
                      Positioned(
                        right: -8,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            count > 99 ? '99+' : '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final String price;
  final String rating;
  final String type;
  final String spicy;
  final String time;
  final bool isFavorite;

  final VoidCallback onTap;
  final VoidCallback onAdd;
  final VoidCallback onFavorite;

  const FoodCard({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.type,
    required this.spicy,
    required this.time,
    required this.isFavorite,
    required this.onTap,
    required this.onAdd,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final isVeg = type == "Veg";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xff171C22),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
              child: Image.asset(
                image,
                width: 120,
                height: 155,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 155,
                    color: const Color(0xff222831),
                    child: const Icon(
                      Icons.fastfood,
                      color: Colors.grey,
                      size: 40,
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onFavorite,
                          child: Container(
                            width: 28,
                            height: 28,
                            margin: const EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              color: isFavorite
                                  ? Colors.red.withValues(alpha: 0.12)
                                  : const Color(0xff222831),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isVeg ? Colors.green : Colors.red,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isVeg ? Colors.green : Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(rating),
                        const Spacer(),
                        Text(
                          price,
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        smallInfo(Icons.timer_outlined, time),
                        smallInfo(Icons.local_fire_department, spicy),
                      ],
                    ),

                    const SizedBox(height: 7),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          type,
                          style: TextStyle(
                            color: isVeg ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: onAdd,
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget smallInfo(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff222831),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: Colors.orange,
          ),
          const SizedBox(width: 3),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}