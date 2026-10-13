class CartItem {
  final String image;
  final String name;
  final String price;
  final double priceValue;

  int quantity;

  CartItem({
    required this.image,
    required this.name,
    required this.price,
    required this.priceValue,
    this.quantity = 1,
  });
}