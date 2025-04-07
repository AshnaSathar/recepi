import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/recipe_controller.dart';
import 'package:flutter_application_1/model/recipe_model.dart';
import 'package:flutter_application_1/view/item_recipe.dart';
import 'package:flutter_application_1/view/product_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/constants/color_constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _filterItems(String query) {
    Provider.of<RecipeController>(context, listen: false).searchRecipe(query);
  }

  @override
  Widget build(BuildContext context) {
    final dataList = Provider.of<RecipeController>(context).recipes ?? [];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 246, 244),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Search Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Soft shadow color
                    blurRadius: 6, // Spread of the shadow
                    offset: const Offset(0, 3), // Vertical shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Search items by ingredient...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: _filterItems,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: dataList.isEmpty
                  ? const Center(child: Text('No items found'))
                  : ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final recipe = dataList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 4.0),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              tileColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: Text(
                                recipe.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ItemRecipe(recipe: recipe),
                                    ));
                              },
                            ),
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

//   void _showRecipeDetails(BuildContext context, Recipe recipe) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(recipe.name),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("Ingredients:"),
//               Text(recipe.description),
//               const SizedBox(height: 8),
//               const Text("Cooking Method:"),
//               Text(recipe.instructions),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Close"),
//           ),
//         ],
//       ),
//     );
//   }
// }
