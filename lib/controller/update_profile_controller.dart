import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateProfileController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> updateProfile({
    required String email,
    required String password,
    required String dob,
    required String phone,
    required String username,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var url = Uri.parse('http://127.0.0.1:8000/update_pr');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'user_name': username,
          'email': email,
          'phone': phone,
          'dob': dob,
          'psw': password,
        }),
      );

      print("Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage =
            jsonDecode(response.body)['message'] ?? 'Profile update failed';
      }
    } catch (e) {
      _errorMessage = "Something went wrong: $e";
      print("Error: $_errorMessage");
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
