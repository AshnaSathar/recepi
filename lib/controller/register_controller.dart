import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterController with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> registerUser({
    context,
    required String username,
    required String email,
    required String phone,
    required String dob,
    required String password,
  }) async {
    print("registering as");
    print(username);
    print(password);
    _isLoading = true;
    _errorMessage = null;

    String url = "http://127.0.0.1:8000/register/";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['user_name'] = username;
      request.fields['email'] = email;
      request.fields['phone'] = phone;
      request.fields['dob'] = dob;
      request.fields['psw'] = password;
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print(responseBody);
      if (response.statusCode == 201) {
        _isLoading = false;

        notifyListeners();
        return true;
      } else {
        _errorMessage =
            jsonDecode(responseBody)['message'] ?? 'Registration failed';
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
