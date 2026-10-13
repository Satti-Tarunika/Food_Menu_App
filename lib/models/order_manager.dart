class Order {
  final String orderId;
  final DateTime date;
  final List<String> items;
  final double total;
  final String paymentMethod;
  final String address;

  Order({
    required this.orderId,
    required this.date,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.address,
  });
}

class OrderManager {
  static final List<Order> orders = [];

  static void addOrder(Order order) {
    orders.insert(0, order);
  }
}