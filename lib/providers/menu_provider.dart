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

  // 1. CORE SYNCHRONIZATION PIPELINE
  Future<void> syncMenu(int? studentCanteenId) async {
    _isLoading = true;
    _isOfflineMode = false;
    notifyListeners();

    try {
      final liveData = await _apiService.fetchMenu();

      if (liveData != null && liveData.isNotEmpty) {
        _menuItems = liveData;
        _isOfflineMode = false;
      } else {
        await loadFallbackMenuFromAsset(studentCanteenId);
      }
    } catch (networkError) {
      debugPrint(
        "API gateway unreachable. Triggering asset fallback: $networkError",
      );
      await loadFallbackMenuFromAsset(studentCanteenId);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 2. DISK FILE READ PIPELINE - READS DIRECTLY FROM YOUR JSON FILE
  Future<void> loadFallbackMenuFromAsset(int? studentCanteenId) async {
    _isOfflineMode = true;
    try {
      final String localJson = await rootBundle.loadString(
        'assets/data/local_menu.json',
      );
      final List<dynamic> allLocalItems = jsonDecode(localJson);

      // Filter the items by the student's active canteen context
      if (studentCanteenId != null) {
        _menuItems = allLocalItems.where((item) {
          return item['canteen_id'] == studentCanteenId;
        }).toList();
      } else {
        _menuItems = allLocalItems;
      }
    } catch (fileError) {
      debugPrint("Error reading assets/data/local_menu.json: $fileError");
      _menuItems = [];
    }
  }

  // 3. HARDWARE REAL-TIME OVERCEPTOR
  void setOfflineState(bool goOffline, int? studentCanteenId) async {
    if (_isOfflineMode == goOffline) return;

    if (goOffline) {
      await loadFallbackMenuFromAsset(studentCanteenId);
    } else {
      await syncMenu(studentCanteenId);
    }
    notifyListeners();
  }
}
