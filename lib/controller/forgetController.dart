import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgetController with ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  bool isLoading = false;
  String? message;

  Future<void> recoverPassword(username) async {
    print("inside recoveryPassword function");
    print(username);
    if (username.isEmpty) {
      message = "Please enter your username";
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://127.0.0.1:8000/forg_pass/');
    try {
      final response = await http.post(
        url,
        body: {'user_name': username},
      );
      print("response for this api call from backend is");
      print(response.body);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        message = data['message'];
      } else {
        message = data['message'];
      }
    } catch (e) {
      print(
        "Error message is",
      );
      print(e);
      message = "An error occurred. Please try again.";
    }

    isLoading = false;
    notifyListeners();
  }
}
