import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/cart_manager.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = "UPI";

  // Demo QR only. Replace with the restaurant's real UPI ID.
  static const String restaurantUpiId = 'foodie@okaxis';
  static const String restaurantName = 'Foodie Restaurant';

  void placeOrder() {
    if (CartManager.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your cart is empty")),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xff171C22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  color: Color(0xff16351F),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Order Placed!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your order has been placed successfully.\n"
                "Your delicious food is on the way! 🍔",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Order Total: ₹${CartManager.total.toStringAsFixed(0)}",
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    CartManager.items.clear();
                    CartManager.itemCount.value = 0;

                    Navigator.pop(dialogContext);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget paymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final bool selected = selectedPayment == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xff171C22),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected ? Colors.orange : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: const Color(0xff211A10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.orange,
                size: 25,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected ? Colors.orange : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentDetails() {
    if (selectedPayment == "UPI") {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: const Color(0xff171C22),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          "Pay using Google Pay, PhonePe or any UPI app.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    if (selectedPayment == "Card") {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: const Color(0xff171C22),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          "Card payment UI can be connected to a payment gateway.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // Show the QR only when Cash on Delivery is selected.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: const Color(0xff171C22),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(
                Icons.delivery_dining,
                color: Colors.orange,
                size: 30,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Pay on delivery or scan the restaurant QR",
                  style: TextStyle(
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Restaurant Payment QR",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          QrImageView(
            data:
                'upi://pay?pa=$restaurantUpiId&pn=${Uri.encodeComponent(restaurantName)}',
            version: QrVersions.auto,
            size: 200,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(12),
          ),
          const SizedBox(height: 8),
          const Text(
            "DEMO QR CODE",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Replace the demo UPI ID with the restaurant's real UPI ID "
            "before accepting payments.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xff0D1117),
        elevation: 0,
        title: const Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose Payment Method",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            paymentOption(
              title: "UPI",
              subtitle: "Pay using Google Pay, PhonePe or any UPI app",
              icon: Icons.account_balance_wallet_outlined,
            ),

            paymentOption(
              title: "Card",
              subtitle: "Credit Card or Debit Card",
              icon: Icons.credit_card,
            ),

            paymentOption(
              title: "Cash on Delivery",
              subtitle: "Pay when your order arrives",
              icon: Icons.money,
            ),

            // The selected method controls which details appear here.
            paymentDetails(),

            const SizedBox(height: 30),
            const Text(
              "Order Total",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xff171C22),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "₹${CartManager.total.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  selectedPayment == "Cash on Delivery"
                      ? "Place Order"
                      : "Pay ₹${CartManager.total.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
