import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/recipe_model.dart';

class RecipeController with ChangeNotifier {
  List<RecipeModel> recipes = [];
  bool isLoading = false;

  Future<void> searchRecipe(List<String> ingredients) async {
    if (ingredients.isEmpty) return;

    isLoading = true;
    notifyListeners();

    try {
      final response = await fetchRecipeFromAPI(ingredients);
      if (response.isNotEmpty) {
        recipes = response;
      } else {
        recipes = [];
      }
    } catch (e) {
      print("Error fetching recipes: $e");
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<RecipeModel>> fetchRecipeFromAPI(List<String> ingredients) async {
    final String baseUrl = "http://127.0.0.1:8000/recommend";
    final String queryString =
        "ingredients=${Uri.encodeComponent(ingredients.join(', '))}";
    final Uri apiUrl = Uri.parse("$baseUrl?$queryString");

    print("Request URL: $apiUrl");

    try {
      final response = await http.get(apiUrl);
      print("Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['recipes'] as List)
            .map((recipe) => RecipeModel.fromJson(recipe))
            .toList();
      } else {
        throw Exception(
            "Failed to load recipes. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during API call: $e");
      return [];
    }
  }
}
