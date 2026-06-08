import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:q_less_campus/services/api_service.dart';

class MenuProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<dynamic> _menuItems = [];
  bool _isLoading = false;
  bool _isOfflineMode = false;

  List<dynamic> get menuItems => _menuItems;
  bool get isLoading => _isLoading;
  bool get isOfflineMode => _isOfflineMode;

  // handel the dynamic online
  Future<void> syncMenu(int? studentCanteenId) async {
    _isLoading = true;
    notifyListeners();

    final liveData = await _apiService.fetchMenu();

    if (liveData != null && liveData.isNotEmpty) {
      _menuItems = liveData;
      _isOfflineMode = false;
    } else {
      _isOfflineMode = true;
      try {
        final String localJson = await rootBundle.loadString(
          'assets/data/local_menu.json',
        );

        final Map<String, dynamic> decodedData = jsonDecode(localJson);
        final List<dynamic> allLocalItems = decodedData['menu'] ?? [];

        if (studentCanteenId != null) {
          _menuItems = allLocalItems.where((item) {
            return item['canteen_id'] == studentCanteenId;
          }).toList();
        } else {
          _menuItems = allLocalItems; // Fallback to all if no ID is present
        }
      } catch (e) {
        _menuItems = [];
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
