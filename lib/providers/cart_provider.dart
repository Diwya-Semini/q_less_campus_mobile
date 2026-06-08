import 'package:flutter/material.dart';
import 'package:q_less_campus/helpers/cart_db_helper.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  CartProvider() {
    loadCartFromDatabase(); // loads saved database
  }

  // Fetch items from sqflite and refresh the memory list
  Future<void> loadCartFromDatabase() async {
    final data = await CartDBHelper.getCartItems();
    _cartItems = List<Map<String, dynamic>>.from(data);
    notifyListeners();
  }

  // Add item to cart
  Future<void> addToCart(Map<String, dynamic> item) async {
    await CartDBHelper.addToCart(item); // Writes to sqflite database disk
    await loadCartFromDatabase(); // Reloads memory list from database
  }

  // Decrement or update quantity
  Future<void> decrementQuantity(int id) async {
    // Find the item inside memory
    final index = _cartItems.indexWhere((element) => element['id'] == id);
    if (index != -1) {
      final currentQty = _cartItems[index]['quantity'] ?? 1;
      if (currentQty > 1) {
        await CartDBHelper.removeFromCart(id);
        final updatedItem = Map<String, dynamic>.from(_cartItems[index]);
        updatedItem['quantity'] = currentQty - 1;
      } else {
        await CartDBHelper.removeFromCart(id);
      }
      await loadCartFromDatabase();
    }
  }

  Future<void> incrementQuantity(int id) async {
    final index = _cartItems.indexWhere((element) => element['id'] == id);
    if (index != -1) {
      await CartDBHelper.addToCart(
        _cartItems[index],
      ); // updates qty inside your helper logic
      await loadCartFromDatabase();
    }
  }

  // Clear cart table completely on successful checkout
  Future<void> clearCart() async {
    await CartDBHelper.clearCart(); // Wipes sqflite table
    _cartItems.clear(); // Clears UI memory state
    notifyListeners();
  }

  // Calculate grand total from database values dynamically
  double get totalAmount {
    double total = 0.0;
    for (var item in _cartItems) {
      final double price = double.tryParse(item['price'].toString()) ?? 0.0;
      final int qty = item['quantity'] ?? 1;
      total += (price * qty);
    }
    return total;
  }
}
