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
      name: json['name'],
      description: json['description'],
      prepTime: json['prep_time'].toDouble(),
      cuisine: json['cuisine'],
      instructions: json['instructions'],
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

class RecipeList {
  final List<Recipe> recipes;

  RecipeList({required this.recipes});

  factory RecipeList.fromJson(Map<String, dynamic> json) {
    return RecipeList(
      recipes: (json['recipes'] as List)
          .map((recipe) => Recipe.fromJson(recipe))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipes': recipes.map((recipe) => recipe.toJson()).toList(),
    };
  }
}
