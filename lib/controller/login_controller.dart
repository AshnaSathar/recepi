import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class LoginController with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _userData;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get userData => _userData;

  Future<bool> loginUser(String username, String password) async {
    const String apiUrl = "http://127.0.0.1:8000/login";

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'user_name': username,
          'pword': password,
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      print("Login Response Status: ${response.statusCode}");
      print("Login Response Headers: ${response.headers}");
      print("Login Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (response.headers.containsKey('set-cookie')) {
          print("Session Cookie: ${response.headers['set-cookie']}");
        } else {
          print("Session ID missing in response.");
        }

        return data['status'] == 'success';
      } else {
        return false;
      }
    } catch (e) {
      print("Login Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _storeSessionId(
      Map<String, String> headers, SharedPreferences prefs) async {
    String? rawCookies = headers['set-cookie'];
    if (rawCookies != null) {
      List<String> cookies = rawCookies.split(';');
      for (String cookie in cookies) {
        if (cookie.trim().startsWith("sessionid=")) {
          String sessionId = cookie.split("=")[1];
          await prefs.setString('sessionid', sessionId);
          print("Stored Session ID: \$sessionId");
          break;
        }
      }
    }
  }

  String _parseErrorMessage(String responseBody) {
    try {
      final jsonData = json.decode(responseBody);
      return jsonData['message'] ?? 'Login failed';
    } catch (e) {
      return 'Unexpected error occurred';
    }
  }
}
