import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';
import 'package:flutter_application_1/constants/text_style.dart';
import 'package:flutter_application_1/controller/save_list_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> recipe;

  const ProductDetailPage({super.key, required this.recipe});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();

    final saveListController = context.read<SaveListController>();
    isSaved = saveListController.isRecipeSaved(widget.recipe['name']);
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: height * 0.35,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      recipe['image'] ?? 'assets/default_image.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      context.go(
                        '/nav-page/0',
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Card(
            color: Colors.white,
            elevation: 3,
            shape: Border.all(color: Colors.white),
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipe['name'] ?? 'Recipe Name',
                          style: TextStyles.h4
                              .copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: toggleSave,
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(recipe['time'] ?? "Time not available"),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.amber),
                      Text(recipe['rating']?.toString() ?? "N/A")
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle("Ingredients"),
                    _buildIngredientsList(),
                    const SizedBox(height: 16),
                    sectionTitle("Steps"),
                    _buildRecipeSteps(),
                    const SizedBox(height: 16),
                    sectionTitle("Cooking Method"),
                    Text(
                      recipe['method'] ??
                          "Detailed cooking method is not available.",
                      style: TextStyles.normalText
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: TextStyles.h5.copyWith(fontWeight: FontWeight.bold),
    );
  }

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });

    final saveListController = context.read<SaveListController>();
    if (isSaved) {
      saveListController.addRecipe(widget.recipe);
      showSnackBar("${widget.recipe['name']} added to saved list");
    } else {
      saveListController.removeRecipe(widget.recipe['name']);
      showSnackBar("${widget.recipe['name']} removed from saved list");
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildIngredientsList() {
    final ingredients = (widget.recipe['ingredients'] as List<dynamic>?) ?? [];

    if (ingredients.isEmpty) {
      return Text("No ingredients listed.", style: TextStyles.normalText);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredients
          .map((ingredient) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "• $ingredient",
                  style: TextStyles.normalText
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildRecipeSteps() {
    final steps = (widget.recipe['steps'] as List<dynamic>?) ?? [];

    if (steps.isEmpty) {
      return Text("No steps available.", style: TextStyles.normalText);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps
          .asMap()
          .entries
          .map((entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  "${entry.key + 1}. ${entry.value}",
                  style: TextStyles.normalText
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ))
          .toList(),
    );
  }
}
