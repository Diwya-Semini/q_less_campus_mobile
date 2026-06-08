import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // future function to get device info
  Future<String> _getDeviceSignature() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return "${androidInfo.manufacturer} ${androidInfo.model}";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.name;
      }
    } catch (_) {}
    return "Campus Mobile App Client";
  }

  // future function to return bearer token
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // 1. login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final String deviceName = await _getDeviceSignature();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'device_name': deviceName,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', responseData['token']);
        await prefs.setString(
          'user_name',
          responseData['user']['name'] ?? 'Student',
        );

        return {'success': true, 'message': 'Logged in successfully'};
      }

      return {
        'success': false,
        'message': responseData['message'] ?? 'Invalid credentials',
      };
    } catch (e) {
      return {'success': false, 'message': 'Network connection failed'};
    }
  }

  // 2. register method
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/register');
    final String deviceName = await _getDeviceSignature();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
          'device_name': deviceName,
        }),
      );

      final responseData = jsonDecode(response.body);

      if ((response.statusCode == 201 || response.statusCode == 200) &&
          responseData['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', responseData['token']);
        await prefs.setString('user_name', name);
        return {'success': true, 'message': 'Account created successfully'};
      }

      return {
        'success': false,
        'message': responseData['message'] ?? 'Registration rejected.',
      };
    } catch (e) {
      return {'success': false, 'message': 'Network connection failed'};
    }
  }

  //2. Menu fetching method
  Future<List<dynamic>?> fetchMenu() async {
    final url = Uri.parse('$baseUrl/menu');
    final token = await _getToken();

    if (token == null) {
      print('Menu Fetch Cancelled: No auth token cached yet.');
      return null;
    }

    try {
      final response = await http
          .get(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic>) {
          return responseData['menu'] ?? responseData['data'] ?? [];
        }

        return responseData as List<dynamic>;
      } else {
        print('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Menu fetching exception: $e');
    }
    return null;
  }

  // 3. Place order method
  Future<dynamic> placeOrder(
    double totalAmount,
    List<Map<String, dynamic>> cartItems,
  ) async {
    final url = Uri.parse('$baseUrl/orders');
    final token = await _getToken();

    try {
      final List<Map<String, dynamic>> formattedItems = cartItems.map((item) {
        return {'id': item['id'], 'qty': item['quantity'] ?? 1};
      }).toList();

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'total_amount': totalAmount,
          'items': formattedItems,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'status': 'error', 'message': 'Network connection failed.'};
    }
  }

  // 4. Get student order
  Future<List<dynamic>> fetchStudentOrders() async {
    final url = Uri.parse('$baseUrl/orders');
    final token = await _getToken();

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          return responseData['orders'] as List<dynamic>;
        }
      }
    } catch (e) {
      debugPrint("API Error fetching orders: $e");
    }
    return [];
  }

  // 5. logout method
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
