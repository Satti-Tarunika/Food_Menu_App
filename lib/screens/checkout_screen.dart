import 'package:flutter/material.dart';

import '../models/cart_manager.dart';
import 'payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() =>
      _CheckoutScreenState();
}

class _CheckoutScreenState
    extends State<CheckoutScreen> {

  String selectedAddress = "College";

  final TextEditingController addressController =
      TextEditingController(
    text:
        "SVECW Campus, Bhimavaram, Andhra Pradesh",
  );

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  void changeAddress() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff171C22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Address",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              addressOption(
                "Home",
                "Bhimavaram, Andhra Pradesh",
              ),

              addressOption(
                "College",
                "SVECW Campus, Bhimavaram",
              ),

              ListTile(
                leading: const Icon(
                  Icons.add_location_alt_outlined,
                  color: Colors.orange,
                ),
                title: const Text(
                  "Add New Address",
                ),
                onTap: () {
                  Navigator.pop(context);
                  addNewAddress();
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget addressOption(
    String title,
    String subtitle,
  ) {
    final bool selected =
        selectedAddress == title;

    return ListTile(
      leading: Icon(
        title == "Home"
            ? Icons.home_outlined
            : Icons.school_outlined,
        color: Colors.orange,
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),

      trailing: Icon(
        selected
            ? Icons.radio_button_checked
            : Icons.radio_button_off,
        color: selected
            ? Colors.orange
            : Colors.grey,
      ),

      onTap: () {
        setState(() {
          selectedAddress = title;
          addressController.text = subtitle;
        });

        Navigator.pop(context);
      },
    );
  }

  void addNewAddress() {
    final controller =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              const Color(0xff171C22),

          title: const Text(
            "Add New Address",
          ),

          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  "Enter delivery address",
              filled: true,
              fillColor:
                  const Color(0xff222831),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
                borderSide:
                    BorderSide.none,
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
              ),
            ),

            ElevatedButton(
              onPressed: () {
                if (controller.text
                    .trim()
                    .isNotEmpty) {
                  setState(() {
                    selectedAddress = "Other";
                    addressController.text =
                        controller.text.trim();
                  });

                  Navigator.pop(context);
                }
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.orange,
                foregroundColor:
                    Colors.white,
              ),

              child: const Text(
                "Save",
              ),
            ),
          ],
        );
      },
    );
  }

  void continueToPayment() {
    if (CartManager.items.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Your cart is empty",
          ),
        ),
      );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const PaymentScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xff0D1117),

      appBar: AppBar(
        backgroundColor:
            const Color(0xff0D1117),
        elevation: 0,

        title: const Text(
          "Checkout",
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const Text(
              "Delivery Address",
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding:
                  const EdgeInsets.all(15),

              decoration:
                  BoxDecoration(
                color:
                    const Color(0xff171C22),
                borderRadius:
                    BorderRadius.circular(15),
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(10),

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(0xff211A10),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),

                    child: const Icon(
                      Icons.location_on,
                      color:
                          Colors.orange,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Row(
                          children: [
                            Text(
                              selectedAddress,
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const Spacer(),

                            TextButton(
                              onPressed:
                                  changeAddress,

                              child:
                                  const Text(
                                "Change",
                                style:
                                    TextStyle(
                                  color:
                                      Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Text(
                          addressController.text,
                          style:
                              const TextStyle(
                            color:
                                Colors.grey,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Order Summary",
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding:
                  const EdgeInsets.all(15),

              decoration:
                  BoxDecoration(
                color:
                    const Color(0xff171C22),
                borderRadius:
                    BorderRadius.circular(15),
              ),

              child: Column(
                children: [
                  for (var item
                      in CartManager.items)
                    Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 15,
                      ),

                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(10),

                            child: Image.asset(
                              item.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,

                              errorBuilder:
                                  (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color:
                                      const Color(
                                    0xff222831,
                                  ),
                                  child:
                                      const Icon(
                                    Icons.fastfood,
                                    color:
                                        Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [
                                Text(
                                  item.name,
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow
                                          .ellipsis,

                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                Text(
                                  "Qty: ${item.quantity}",
                                  style:
                                      const TextStyle(
                                    color:
                                        Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            "₹${(item.priceValue * item.quantity).toStringAsFixed(0)}",

                            style:
                                const TextStyle(
                              color:
                                  Colors.orange,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Bill Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding:
                  const EdgeInsets.all(18),

              decoration:
                  BoxDecoration(
                color:
                    const Color(0xff171C22),
                borderRadius:
                    BorderRadius.circular(15),
              ),

              child: Column(
                children: [
                  billRow(
                    "Subtotal",
                    "₹${CartManager.subtotal.toStringAsFixed(0)}",
                  ),

                  const SizedBox(height: 12),

                  billRow(
                    "Delivery Fee",
                    "₹${CartManager.deliveryFee.toStringAsFixed(0)}",
                  ),

                  const Padding(
                    padding:
                        EdgeInsets.symmetric(
                      vertical: 15,
                    ),

                    child: Divider(
                      color:
                          Colors.grey,
                    ),
                  ),

                  billRow(
                    "Total",
                    "₹${CartManager.total.toStringAsFixed(0)}",
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 58,

              child: ElevatedButton(
                onPressed:
                    continueToPayment,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.orange,
                  foregroundColor:
                      Colors.white,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [
                    const Text(
                      "Continue to Payment",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Icon(
                      Icons.arrow_forward,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget billRow(
    String title,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,

          style: TextStyle(
            color: isTotal
                ? Colors.white
                : Colors.grey,

            fontSize:
                isTotal ? 17 : 14,

            fontWeight: isTotal
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),

        Text(
          value,

          style: TextStyle(
            color: isTotal
                ? Colors.orange
                : Colors.white,

            fontSize:
                isTotal ? 19 : 14,

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    );
  }
}