class RecipeModel {
  final String? name;
  final String? description;
  final String? prepTime;
  final double? calories;
  final List<String>? recipeInstructions; // Changed from String to List<String>
  final double? proteinContent;
  final double? similarityScore;
  final String? matchType;

  RecipeModel({
    this.name,
    this.description,
    this.prepTime,
    this.calories,
    this.recipeInstructions,
    this.proteinContent,
    this.similarityScore,
    this.matchType,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      name: json['Name'],
      description: json['Description'],
      prepTime: json['PrepTime'],
      calories: json['Calories']?.toDouble(),
      recipeInstructions: _parseRecipeInstructions(json['RecipeInstructions']),
      proteinContent: json['ProteinContent']?.toDouble(),
      similarityScore: json['SimilarityScore']?.toDouble(),
      matchType: json['MatchType'],
    );
  }

  static List<String> _parseRecipeInstructions(dynamic instructions) {
    if (instructions is List) {
      return instructions.map((e) => e.toString()).toList();
    } else if (instructions is String) {
      return instructions
          .replaceAll('c("', '') // Remove 'c("'
          .replaceAll('")', '') // Remove closing '")'
          .split('", "') // Split into a list
          .map((e) => e.trim()) // Trim spaces
          .toList();
    }
    return [];
  }
}
