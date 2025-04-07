import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/profile_model.dart';

class ProfileController with ChangeNotifier {
  ProfileModel? profile;
  bool isLoading = false;

  Future<void> fetchProfile() async {
    try {
      isLoading = true;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      String? sessionId = prefs.getString('sessionid');

      if (sessionId == null || sessionId.isEmpty) {
        print("Error: Session ID is missing");
        return;
      }

      var response = await http.get(
        Uri.parse('http://127.0.0.1:8000/profile_view'),
        headers: {
          'Cookie': 'sessionid=$sessionId',
        },
      );

      print('Profile Response Status: ${response.statusCode}');
      print('Profile Response Body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('application/json') !=
            true) {
          print('Error: Received non-JSON response.');
          return;
        }

        final jsonData = jsonDecode(response.body);
        if (jsonData is! Map<String, dynamic>) {
          print('Error: Unexpected JSON format');
          return;
        }

        if (jsonData['status'] == 'success' && jsonData.containsKey('data')) {
          profile = ProfileModel.fromJson(jsonData['data']);
          notifyListeners();
        } else {
          print("Error: ${jsonData['error'] ?? 'Unknown error'}");
        }
      } else {
        print("Error fetching profile: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateProfile(Map<String, String> updatedData) {
    if (profile == null) return;

    profile = ProfileModel(
      email: updatedData["email"] ?? profile!.email,
      dob: updatedData["dob"] ?? profile!.dob,
      phone: updatedData["phone"] ?? profile!.phone,
      photoUrl: updatedData["photo_url"] ?? profile!.photoUrl,
    );
    notifyListeners();
  }
}
