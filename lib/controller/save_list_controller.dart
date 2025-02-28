import 'package:flutter/material.dart';

class SaveListController extends ChangeNotifier {
  final List<Map<String, dynamic>> _savedRecipes = [];

  List<Map<String, dynamic>> get savedRecipes => _savedRecipes;

  void addRecipe(Map<String, dynamic> recipe) {
    if (!_savedRecipes.any((item) => item['name'] == recipe['name'])) {
      _savedRecipes.add(recipe);
      notifyListeners();
    }
  }

  void removeRecipe(String recipeName) {
    _savedRecipes.removeWhere((item) => item['name'] == recipeName);
    notifyListeners();
  }

  bool isRecipeSaved(String recipeName) {
    return _savedRecipes.any((item) => item['name'] == recipeName);
  }
}
