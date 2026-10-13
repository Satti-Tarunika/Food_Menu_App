import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const FoodMenuApp());
}

class FoodMenuApp extends StatelessWidget {
  const FoodMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Menu App',

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff0D1117),
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),

      // Open Login screen first
      home: const LoginScreen(),
    );
  }
}