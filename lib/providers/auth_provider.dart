import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _currentUserName;
  String? _token;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get currentUserName => _currentUserName;
  String? get token => _token;

  // method for detecting the device
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

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final Uri url = Uri.parse('http://10.0.2.2:8000/api/login');
    final String actualDeviceName = await _getDeviceSignature();

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
          'device_name': actualDeviceName,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['token'] != null) {
        //success - st local phone storage
        final prefs = await SharedPreferences.getInstance();
        _token = responseData['token'];
        await prefs.setString('auth_token', responseData['token']);

        // save user name to local disk to custom header
        String name = responseData['user']['name'] ?? 'Student';
        await prefs.setString('user_name', name);
        _currentUserName = name;

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage =
            responseData['message'] ?? 'Invalid credentials entered.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      _errorMessage = 'Cannot connet to backend server.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final Uri url = Uri.parse('http://10.0.2.2:8000/api/register');
    final String actualDeviceName = await _getDeviceSignature();

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
          'device_name': actualDeviceName,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        //save token and names to shared prefs
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', responseData['token']);
        await prefs.setString('user_name', name);
        _currentUserName = name;

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage =
            responseData['message'] ?? 'Registration validation failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      _errorMessage = 'Connection failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user_name')) {
      _currentUserName = prefs.getString('user_name');
      notifyListeners();
    }
  }
}
