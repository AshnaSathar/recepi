import 'package:flutter/material.dart';
import '../model/recipe_model.dart';
import '../constants/color_constants.dart';

class ItemRecipe extends StatelessWidget {
  final RecipeModel recipe;

  const ItemRecipe({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        title: Text(recipe.name ?? "Recipe"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                recipe.name ?? "Recipe Name",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Prep Time: ${recipe.prepTime ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.red),
                    onPressed: () {
                      //  save action here
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Calories: ${recipe.calories?.toStringAsFixed(2) ?? 'N/A'} kcal",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Protein: ${recipe.proteinContent?.toStringAsFixed(2) ?? 'N/A'} g",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Similarity Score: ${recipe.similarityScore?.toStringAsFixed(2) ?? 'N/A'} ",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                "Match Type: ${recipe.matchType ?? 'N/A'} ",
                style: const TextStyle(fontSize: 16),
              ),
              const Text(
                "Instructions:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              recipe.recipeInstructions != null &&
                      recipe.recipeInstructions!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recipe.recipeInstructions!.map((step) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text("- $step",
                              style: const TextStyle(fontSize: 16)),
                        );
                      }).toList(),
                    )
                  : const Text("No instructions available",
                      style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
