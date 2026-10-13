import 'package:flutter/material.dart';

import '../models/cart_manager.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() =>
      _CartScreenState();
}

class _CartScreenState
    extends State<CartScreen> {

  void refreshCart() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final items = CartManager.items;

    return Scaffold(
      backgroundColor:
          const Color(0xff0D1117),

      appBar: AppBar(
        backgroundColor:
            const Color(0xff0D1117),

        elevation: 0,

        title: const Text(
          "My Cart",

          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: items.isEmpty
          ? emptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(
                      16,
                    ),

                    itemCount:
                        items.length,

                    itemBuilder:
                        (context, index) {
                      final item =
                          items[index];

                      return cartItem(
                        index,
                        item,
                      );
                    },
                  ),
                ),

                bottomSummary(),
              ],
            ),
    );
  }

  Widget emptyCart() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Container(
              padding:
                  const EdgeInsets.all(
                25,
              ),

              decoration:
                  BoxDecoration(
                color:
                    const Color(0xff171C22),

                shape:
                    BoxShape.circle,
              ),

              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 60,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Your cart is empty",

              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Add some delicious food\nand come back here!",

              textAlign:
                  TextAlign.center,

              style: TextStyle(
                color: Colors.grey,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.orange,

                foregroundColor:
                    Colors.white,

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 13,
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),

              child: const Text(
                "Browse Food",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cartItem(
    int index,
    dynamic item,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 15,
      ),

      padding:
          const EdgeInsets.all(12),

      decoration:
          BoxDecoration(
        color:
            const Color(0xff171C22),

        borderRadius:
            BorderRadius.circular(
          15,
        ),
      ),

      child: Row(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(
              12,
            ),

            child: Image.asset(
              item.image,

              width: 85,
              height: 85,

              fit: BoxFit.cover,

              errorBuilder:
                  (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  width: 85,
                  height: 85,

                  color:
                      const Color(
                    0xff222831,
                  ),

                  child:
                      const Icon(
                    Icons.fastfood,
                    color:
                        Colors.grey,
                    size: 35,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  item.name,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      const TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  item.price,

                  style:
                      const TextStyle(
                    color:
                        Colors.orange,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    quantityButton(
                      Icons.remove,
                      () {
                        CartManager
                            .decreaseQuantity(
                          index,
                        );

                        refreshCart();
                      },
                    ),

                    Padding(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                      ),

                      child: Text(
                        item.quantity
                            .toString(),

                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    quantityButton(
                      Icons.add,
                      () {
                        CartManager
                            .increaseQuantity(
                          index,
                        );

                        refreshCart();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              CartManager.removeItem(
                index,
              );

              refreshCart();
            },

            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget quantityButton(
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding:
            const EdgeInsets.all(7),

        decoration:
            BoxDecoration(
          color:
              const Color(0xff211A10),

          borderRadius:
              BorderRadius.circular(
            8,
          ),
        ),

        child: Icon(
          icon,

          size: 17,

          color:
              Colors.orange,
        ),
      ),
    );
  }

  Widget bottomSummary() {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        20,
      ),

      decoration:
          const BoxDecoration(
        color:
            Color(0xff171C22),

        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(
            25,
          ),
        ),
      ),

      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [
                const Text(
                  "Subtotal",

                  style:
                      TextStyle(
                    color:
                        Colors.grey,
                  ),
                ),

                Text(
                  "₹${CartManager.subtotal.toStringAsFixed(0)}",

                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [
                const Text(
                  "Delivery Fee",

                  style:
                      TextStyle(
                    color:
                        Colors.grey,
                  ),
                ),

                Text(
                  "₹${CartManager.deliveryFee.toStringAsFixed(0)}",

                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Divider(
              height: 25,
              color: Colors.grey,
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [
                const Text(
                  "Total",

                  style:
                      TextStyle(
                    fontSize: 19,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                Text(
                  "₹${CartManager.total.toStringAsFixed(0)}",

                  style:
                      const TextStyle(
                    color:
                        Colors.orange,
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            SizedBox(
              width:
                  double.infinity,

              height: 55,

              child:
                  ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder:
                          (context) =>
                              const CheckoutScreen(),
                    ),
                  );
                },

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.orange,

                  foregroundColor:
                      Colors.white,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),
                  ),
                ),

                child: const Text(
                  "Proceed to Checkout",

                  style:
                      TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}