import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/cart_db_helper.dart';

class OrderProvider with ChangeNotifier {
  bool _isSubmitting = false;
  Map<String, dynamic>? _activeOrder;
  String? _errorMessage;

  bool get isSubmitting => _isSubmitting;
  Map<String, dynamic>? get activeOrder => _activeOrder;
  String? get errorMessage => _errorMessage;

  // method handling the network POST mapping to API
  Future<bool> submitOrder({
    required List<Map<String, dynamic>> cartItems,
    required double totalAmount,
    required String? authToken,
  }) async {
    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    final List<Map<String, dynamic>> formattedItems = cartItems.map((item) {
      return {'id': item['id'], 'qty': item['quantity']};
    }).toList();

    final Map<String, dynamic> payload = {
      'total_amount': totalAmount,
      'items': formattedItems,
    };

    final Uri url = Uri.parse('http://10.0.2.2:8000/api/orders');

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 5));

      final responseData = jsonDecode(response.body);

      if ((response.statusCode == 201 || response.statusCode == 200) &&
          responseData['status'] == 'success') {
        _activeOrder = responseData['order'];

        // Wipe local SQFlite records
        await CartDBHelper.clearCart();

        _isSubmitting = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage =
            responseData['message'] ??
            'Submission rejected by canteen database.';
        _isSubmitting = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      _errorMessage =
          'Network connection failed. Verify your server is online.';
      _isSubmitting = false;
      notifyListeners();
      return false;
    }
  }

  // Clear out active tracking reference when student leaves history views
  void resetActiveOrder() {
    _activeOrder = null;
  }
}
