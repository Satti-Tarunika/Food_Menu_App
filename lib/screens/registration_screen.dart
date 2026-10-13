import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  
Future<void> register() async {
  String name = nameController.text.trim();
  String email = emailController.text.trim();
  String password = passwordController.text;
  String confirmPassword = confirmPasswordController.text;

  if (name.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty) {
    showMessage('Please fill in all fields');
    return;
  }

  if (!email.contains('@') || !email.contains('.')) {
    showMessage('Please enter a valid email address');
    return;
  }

  if (password.length < 8) {
    showMessage('Password must contain at least 8 characters');
    return;
  }

  if (password != confirmPassword) {
    showMessage('Passwords do not match');
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'full_name': name,
        'email': email,
        'phone': '',
        'password': password,
      }),
    );

    final result = jsonDecode(response.body);

    if (!mounted) return;

    if (response.statusCode == 201) {
      showMessage('Registration successful! Please log in.');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      showMessage(result['message'] ?? 'Registration failed');
    }
  } catch (e) {
  print('Registration error: $e');

  if (!mounted) return;
  showMessage('Registration error: $e');
}
}
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xff0D1117),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_add_alt_1,
                color: Colors.orange,
                size: 65,
              ),
              const SizedBox(height: 15),
              const Text(
                'Join Foodie!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Create an account to get started',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              buildField(
                'Full Name',
                'Enter your full name',
                Icons.person_outline,
                nameController,
              ),
              const SizedBox(height: 18),

              buildField(
                'Email Address',
                'Enter your email',
                Icons.email_outlined,
                emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 18),

              buildField(
                'Password',
                'Create a password',
                Icons.lock_outline,
                passwordController,
                obscureText: hidePassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              buildField(
                'Confirm Password',
                'Re-enter your password',
                Icons.lock_outline,
                confirmPasswordController,
                obscureText: hideConfirmPassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      hideConfirmPassword = !hideConfirmPassword;
                    });
                  },
                  icon: Icon(
                    hideConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(
    String label,
    String hint,
    IconData icon,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: Icon(icon, color: Colors.orange),
            suffixIcon: suffix,
            filled: true,
            fillColor: const Color(0xff171C22),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xff292F36)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xff292F36)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.orange),
            ),
          ),
        ),
      ],
    );
  }
}
