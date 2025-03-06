import 'package:flutter/material.dart';

class RecipeSlider extends StatelessWidget {
  final List<Map<String, dynamic>> recipes = const [
    {
      'name': 'Blueberry Cake',
      'image': 'assets/blueberry_dessert.jpg',
      'cookingTime': '30 mins',
      'rating': 4.5,
    },
    {
      'name': 'Prawns Curry',
      'image': 'assets/prawns_curry.jpg',
      'cookingTime': '40 mins',
      'rating': 4.8,
    },
    {
      'name': 'Chilli Chicken',
      'image': 'assets/chilli_chicken.jpg',
      'cookingTime': '20 mins',
      'rating': 4.3,
    },
    {
      'name': 'Chicken Biriyani',
      'image': 'assets/chicken_biriyani.jpg',
      'cookingTime': '15 mins',
      'rating': 4.2,
    },
  ];

  const RecipeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1000) {
      // Large screens (desktop) - 4 columns
      return _buildGridView(4);
    } else if (screenWidth > 600) {
      // Medium screens (tablet) - 2 columns
      return _buildGridView(2);
    } else {
      // Small screens (mobile) - horizontal list
      return SizedBox(
        height: 220, // Adjusted to reduce card height
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recipes.length,
          itemBuilder: (context, index) =>
              _buildRecipeCard(context, recipes[index], isHorizontal: true),
        ),
      );
    }
  }

  Widget _buildGridView(int crossAxisCount) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 3 / 4, // Adjust aspect ratio to control card shape
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) =>
          _buildRecipeCard(context, recipes[index]),
    );
  }

  Widget _buildRecipeCard(BuildContext context, Map<String, dynamic> recipe,
      {bool isHorizontal = false}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = isHorizontal ? screenWidth * 0.45 : double.infinity;
    double imageHeight =
        isHorizontal ? 120 : 150; // Smaller height for horizontal cards
    double fontSize = isHorizontal ? 14 : 16;

    return SizedBox(
      width: isHorizontal ? cardWidth : null,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: imageHeight,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: AssetImage(recipe['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe['name'],
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 16),
                      Text(
                        ' ${recipe['cookingTime']}',
                        style: TextStyle(
                          fontSize: fontSize * 0.85,
                          color: Colors.grey[700],
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        recipe['rating'].toString(),
                        style: TextStyle(fontSize: fontSize * 0.85),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
