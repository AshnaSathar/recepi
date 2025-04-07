import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/recipe_model.dart';
import 'package:http/http.dart' as http;

class RecipeController extends ChangeNotifier {
  List<Recipe> recipes = [];

  Future searchRecipe(String ingredient) async {
    try {
      final url =
          Uri.parse('http://127.0.0.1:8000/recommend/?ingredients=$ingredient');
      var response = await http.get(url);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        recipes = RecipeList.fromJson(jsonResponse).recipes;
        notifyListeners();
      } else {
        print("Failed to fetch recipes");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
