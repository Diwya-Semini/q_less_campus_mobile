import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class MenuProvider extends ChangeNotifier {
  List<Product> _menuItems = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters so the UI can read the state
  List<Product> get menuItems => _menuItems;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // The function to fetch data from Laravel
  Future<void> fetchMenu() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Tells the UI to show a loading spinner

    try {
      // Calls your existing Waiter!
      _menuItems = await ApiService.getMenu();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Tells the UI the data is ready!
    }
  }
}