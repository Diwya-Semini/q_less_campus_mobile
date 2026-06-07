import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;
  String? _currentUserName;
  String? _token;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get currentUserName => _currentUserName;
  String? get token => _token;

  // 1. Login method
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // network handler layer call
    final result = await _apiService.login(email, password);

    if (result['success'] == true) {
      // get data saved inside prefs or from memory cache maps
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('auth_token');
      _currentUserName = prefs.getString('user_name');

      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 2. Register method
  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // network handler layer call
    final result = await _apiService.register(name, email, password);

    if (result['success'] == true) {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('auth_token');
      _currentUserName = name;

      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('auth_token') && prefs.containsKey('user_name')) {
      _token = prefs.getString('auth_token');
      _currentUserName = prefs.getString('user_name');
      notifyListeners();
    }
  }

  // 3. log out method
  Future<void> logout() async {
    await _apiService.logout();
    _token = null;
    _currentUserName = null;
    notifyListeners();
  }
}
