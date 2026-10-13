import 'package:flutter/material.dart';

import '../models/cart_manager.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() =>
      _BottomNavScreenState();
}

class _BottomNavScreenState
    extends State<BottomNavScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(),

      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xff171C22),

        indicatorColor: const Color(0xff211A10),

        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: [
          const NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.grey,
            ),

            selectedIcon: Icon(
              Icons.home,
              color: Colors.orange,
            ),

            label: "Home",
          ),

          NavigationDestination(
            icon: _cartIcon(false),

            selectedIcon: _cartIcon(true),

            label: "Cart",
          ),

          const NavigationDestination(
            icon: Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),

            selectedIcon: Icon(
              Icons.person,
              color: Colors.orange,
            ),

            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _cartIcon(bool selected) {
    return ValueListenableBuilder<int>(
      valueListenable: CartManager.itemCount,

      builder: (
        context,
        count,
        child,
      ) {
        return Stack(
          clipBehavior: Clip.none,

          children: [
            Icon(
              selected
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_outlined,

              color: selected
                  ? Colors.orange
                  : Colors.grey,
            ),

            if (count > 0)
              Positioned(
                right: -10,
                top: -8,

                child: Container(
                  constraints:
                      const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.red,

                    borderRadius:
                        BorderRadius.circular(10),

                    border: Border.all(
                      color: const Color(
                        0xff171C22,
                      ),
                      width: 2,
                    ),
                  ),

                  child: Text(
                    count > 99
                        ? "99+"
                        : count.toString(),

                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _getScreen() {
    if (selectedIndex == 0) {
      return const HomeScreen();
    } else if (selectedIndex == 1) {
      return const CartScreen();
    } else {
      return const ProfileScreen();
    }
  }
}