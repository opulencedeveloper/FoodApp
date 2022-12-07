import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String food;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.food,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {
      ..._items
    };
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach(
      (key, cartItem) {
        total += cartItem.price * cartItem.quantity;
      },
    );
    return total;
  }

  void addItem(
    String productId,
    double price,
    String food,
    String imageUrl,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          food: existingCartItem.food,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          food: food,
          price: price,
          imageUrl: imageUrl,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void reduceItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                food: existingCartItem.food,
                price: existingCartItem.price,
                imageUrl: existingCartItem.imageUrl,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void UndoRemoveSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                food: existingCartItem.food,
                price: existingCartItem.price,
                imageUrl: existingCartItem.imageUrl,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  int get cartItemCount {
    var total = 0;
    _items.forEach(
      (key, cartItem) {
        total += cartItem.quantity;
      },
    );
    return total;
  }

  int itemNumber(String id) {
    var total = 0;
    _items.forEach(
      (key, cartItem) {
        if (id == cartItem.id) {
          total = cartItem.quantity;
        }
      },
    );
    return total;
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
