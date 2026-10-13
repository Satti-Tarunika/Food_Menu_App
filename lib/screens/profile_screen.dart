import 'package:flutter/material.dart';
import 'favorite_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D1117),

      appBar: AppBar(
        backgroundColor: const Color(0xff0D1117),
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 20),

            // PROFILE IMAGE

            Container(
              height: 100,
              width: 100,

              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,

                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 20,
                  ),
                ],
              ),

              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 55,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Foodie User",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "foodie@example.com",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 35),

            ProfileOption(
              icon: Icons.person_outline,
              title: "Edit Profile",
            ),

            ProfileOption(
              icon: Icons.location_on_outlined,
              title: "My Addresses",
            ),

            ProfileOption(
              icon: Icons.receipt_long_outlined,
              title: "Order History",
            ),

            ProfileOption(
  icon: Icons.favorite_border,
  title: "Favorites",

  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const FavoriteScreen(),
      ),
    );
  },
),

            ProfileOption(
              icon: Icons.settings_outlined,
              title: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}


// ======================================================
// PROFILE OPTION
// ======================================================

class ProfileOption extends StatelessWidget {

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      decoration: BoxDecoration(
        color: const Color(0xff171C22),

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: const Color(0xff292F36),
        ),
      ),

      child: ListTile(

        onTap: onTap,

        leading: Icon(
          icon,
          color: Colors.orange,
        ),

        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 16,
        ),
      ),
    );
  }
}