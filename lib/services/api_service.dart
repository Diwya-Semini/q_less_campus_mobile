import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // helper to read the local token
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // 1. Login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final responce = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responceData = jsonDecode(responce.body);

      if (responce.statusCode == 200 && responceData['token'] != null) {
        // sav the token to carry it though the session
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', responceData['token']);
        return {'success': true, 'message': 'Logged in successfully'};
      }

      return {
        'success': false,
        'message': responceData['message'] ?? 'Invalid credentials',
      };
    } catch (e) {
      return {'success': false, 'message': 'Network error connection failed'};
    }
  }

  //2. Menu fetching method
  Future<List<dynamic>?> fetchMenu() async {
    final url = Uri.parse('$baseUrl/menu');
    final token = await _getToken();

    if (token == null) return null;

    try {
      final responce = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (responce.statusCode == 200) {
        return jsonDecode(responce.body);
      }
    } catch (e) {
      print('Menu fetching exception: $e');
    }
    return null;
  }

  // 3. Place order method
  Future<bool> placeOrder(Map<String, dynamic> orderData) async {
    final url = Uri.parse('$baseUrl/orders');
    final token = await _getToken();

    if (token == null) return false;

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(orderData),
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Order Submission Exception: $e');
      return false;
    }
  }

  // 4. logout method
  Future<void> logout() async {
    final url = Uri.parse('$baseUrl/logout');
    final token = await _getToken();

    try {
      await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    } catch (_) {}

    // Erase local saved token
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
