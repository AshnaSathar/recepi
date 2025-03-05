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
    final height = MediaQuery.sizeOf(context).height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;

        // Dynamically set sizes based on screen width
        double cardWidth = screenWidth * 0.45; // Default for mobile
        double imageHeight = height * 0.15;
        double fontSize = 14;

        if (screenWidth > 1200) {
          // Large screen (desktop)
          cardWidth = screenWidth * 0.25;
          imageHeight = height * 0.22;
          fontSize = 18;
        } else if (screenWidth > 800) {
          // Medium screen (tablet)
          cardWidth = screenWidth * 0.3;
          imageHeight = height * 0.18;
          fontSize = 16;
        }

        return SizedBox(
          height: height * 0.32, // Overall slider height
          width: screenWidth,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: cardWidth,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Section
                        Container(
                          height: imageHeight,
                          width: cardWidth,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            image: DecorationImage(
                              image: AssetImage(recipe['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Text and Info Section
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
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 16),
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
                ),
              );
            },
          ),
        );
      },
    );
  }
}
