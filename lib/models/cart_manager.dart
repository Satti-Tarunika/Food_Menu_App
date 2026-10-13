import 'package:flutter/material.dart';

import 'cart_item.dart';

class CartManager {
  static final List<CartItem> items = [];

  static final ValueNotifier<int> itemCount =
      ValueNotifier<int>(0);

  static void _updateCount() {
    int count = 0;

    for (var item in items) {
      count += item.quantity;
    }

    itemCount.value = count;
  }

  static void addItem(CartItem item) {
    for (var existingItem in items) {
      if (existingItem.name == item.name) {
        existingItem.quantity++;
        _updateCount();
        return;
      }
    }

    items.add(item);
    _updateCount();
  }

  static void removeItem(int index) {
    items.removeAt(index);
    _updateCount();
  }

  static void increaseQuantity(int index) {
    items[index].quantity++;
    _updateCount();
  }

  static void decreaseQuantity(int index) {
    if (items[index].quantity > 1) {
      items[index].quantity--;
    } else {
      items.removeAt(index);
    }

    _updateCount();
  }

  static double get subtotal {
    double total = 0;

    for (var item in items) {
      total += item.priceValue * item.quantity;
    }

    return total;
  }

  static double get deliveryFee {
    if (items.isEmpty) {
      return 0;
    }

    return 40;
  }

  static double get total {
    return subtotal + deliveryFee;
  }
}