import 'cart_item.dart';

class FavoriteManager {
  static final List<CartItem> favorites = [];

  static bool isFavorite(String name) {
    return favorites.any(
      (item) => item.name == name,
    );
  }

  static void toggleFavorite(CartItem item) {
    final index = favorites.indexWhere(
      (existingItem) => existingItem.name == item.name,
    );

    if (index >= 0) {
      favorites.removeAt(index);
    } else {
      favorites.add(item);
    }
  }
}