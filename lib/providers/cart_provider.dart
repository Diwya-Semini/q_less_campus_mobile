import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  // memory store array mapping selected food rows
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  double get totalAmount {
    double total = 0.0;
    for (var item in _cartItems) {
      // Safely parse double variants out of database integers or strings
      final price = double.tryParse(item['price'].toString()) ?? 0.0;
      final quantity = int.tryParse(item['quantity'].toString()) ?? 1;
      total += price * quantity;
    }
    return total;
  }

  // add item to basket array
  void addToCart(Map<String, dynamic> item) {
    // check if the item already exists inside our basket
    final existingIndex = _cartItems.indexWhere(
      (cartItem) => cartItem['id'] == item['id'],
    );

    if (existingIndex >= 0) {
      // If it is in cart increment the count
      _cartItems[existingIndex]['quantity'] =
          (_cartItems[existingIndex]['quantity'] ?? 1) + 1;
    } else {
      _cartItems.add({...item, 'quantity': 1});
    }

    notifyListeners();
  }

  // increase item quantity
  void incrementQuantity(int itemId) {
    final index = _cartItems.indexWhere((item) => item['id'] == itemId);
    if (index >= 0) {
      _cartItems[index]['quantity'] = (_cartItems[index]['quantity'] ?? 1) + 1;
      notifyListeners(); 
    }
  }

  // decrease item quantity
  void decrementQuantity(int itemId) {
    final index = _cartItems.indexWhere((item) => item['id'] == itemId);
    if (index >= 0) {
      int currentQty = _cartItems[index]['quantity'] ?? 1;
      if (currentQty > 1) {
        _cartItems[index]['quantity'] = currentQty - 1;
      } else {
        _cartItems.removeAt(index); // Remove item completely if count drops below 1
      }
      notifyListeners(); 
    }
  }

  // remove or decrement items
  void removeFromCart(int itemId) {
    _cartItems.removeWhere((item) => item['id'] == itemId);
    notifyListeners();
  }

  // clear basket
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
