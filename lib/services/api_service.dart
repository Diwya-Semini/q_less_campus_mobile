import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // --- 1. Menu ---
  static Future<List<Product>> getMenu() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/menu'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> menuJson = responseData['data'] ?? [];
        return menuJson.map((json) => Product.fromJson(json)).toList();
      }
      throw Exception('Failed to load menu');
    } catch (e) {
      return []; // Return empty list on failure
    }
  }

  // --- 2. The Login Function ---
  static Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['token'] ?? data['access_token'];

        if (token == null) return "API Error: No token received.";

        // SLEEK NULL-AWARE EXTRACTION
        // The '?[' safely checks if 'user' exists before trying to read 'role'
        final role =
            data['user']?['role']?.toString().toLowerCase() ?? 'student';
        final name = data['user']?['name']?.toString() ?? 'Student';

        if (role != 'student') return "Access Denied: Students only.";

        // OPEN THE VAULT
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user_name', name);

        return null; // null means success!
      }

      return "Login failed. Please check your credentials.";
    } catch (e) {
      return "A network error occurred. Please check your connection.";
    }
  }

  // --- 3. The Logout Function ---
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Safely wipes the entire vault
  }

  // --- 4. The Token Retriever (For future authenticated requests) ---
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // --- 5. User registration ---
  static Future<String?> register(String name, String email, String password, String passwordConfirmation) async{
    try{
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'role': 'student',
        }),
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        final data = json.decode(response.body);
        final token = data['token'] ?? data['access_token'];

        if(token != null){
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);
          await prefs.setString('user_name', name);
          return null; // Registration successful
        }
        return "Account created, but please log in manually.";
      }

      final errorData = json.decode(response.body);
      return errorData['message'] ?? "Registration failed. Please check your details.";
    }catch(e){
      return "A network error occurred. Please check your connection.";
    }

  }

}