class RecipeList {
  final List<Recipe> recipes;

  RecipeList({required this.recipes});

  factory RecipeList.fromJson(Map<String, dynamic> json) {
    var recipesList = json['recipes'] as List;
    List<Recipe> recipes =
        recipesList.map((item) => Recipe.fromJson(item)).toList();
    return RecipeList(recipes: recipes);
  }

  Map<String, dynamic> toJson() {
    return {
      'recipes': recipes.map((recipe) => recipe.toJson()).toList(),
    };
  }
}

class Recipe {
  final String name;
  final String description;
  final double prepTime;
  final String cuisine;
  final String instructions;

  Recipe({
    required this.name,
    required this.description,
    required this.prepTime,
    required this.cuisine,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      prepTime: (json['prep_time'] ?? 0).toDouble(),
      cuisine: json['cuisine'] ?? '',
      instructions: json['instructions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'prep_time': prepTime,
      'cuisine': cuisine,
      'instructions': instructions,
    };
  }
}
