import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/recipe_controller.dart';
import '../view/item_recipe.dart';
import '../constants/color_constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  void _fetchRecipes() {
    String query = _searchController.text.trim();
    if (query.isEmpty) return;

    List<String> ingredients = query.split(',').map((e) => e.trim()).toList();
    Provider.of<RecipeController>(context, listen: false)
        .searchRecipe(ingredients);
  }

  @override
  Widget build(BuildContext context) {
    final recipeController = Provider.of<RecipeController>(context);
    final dataList = recipeController.recipes;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F4),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Search Recipes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔹 Search Bar & Button (Side by Side)
            Row(
              children: [
                // 🔹 TextField (Expanded for responsiveness)
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter ingredients (e.g., tomato, onion)...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // 🔹 Search Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed:
                      _fetchRecipes, // Calls API only when button is pressed
                  child: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 🔹 Recipe List
            Expanded(
              child: recipeController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator()) // Show Loading
                  : dataList.isEmpty
                      ? const Center(child: Text('No recipes found'))
                      : ListView.builder(
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                            final recipe = dataList[index];
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Text(
                                  recipe.name!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ItemRecipe(recipe: recipe),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
