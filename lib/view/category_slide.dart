import 'package:flutter/material.dart';

class RecipeSlider extends StatelessWidget {
  final List<Map<String, dynamic>> recipes = const [
    {
      'name': 'Blueberry cake',
      'image':
          '/Users/ashnasathar/recipeApp/flutter_application_1/assets/blueberry_dessert.jpg',
      'cookingTime': '30 mins',
      'rating': 4.5,
    },
    {
      'name': 'Prawns curry',
      'image':
          '/Users/ashnasathar/recipeApp/flutter_application_1/assets/prawns_curry.jpg',
      'cookingTime': '40 mins',
      'rating': 4.8,
    },
    {
      'name': 'Chilli Chicken',
      'image':
          '/Users/ashnasathar/recipeApp/flutter_application_1/assets/chilli_chicken.jpg',
      'cookingTime': '20 mins',
      'rating': 4.3,
    },
    {
      'name': 'Chicken Biriyani',
      'image':
          '/Users/ashnasathar/recipeApp/flutter_application_1/assets/chicken_biriyani.jpg',
      'cookingTime': '15 mins',
      'rating': 4.2,
    },
  ];

  const RecipeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    double cardWidth =
        width * 0.45; // 40% of screen width (adjust for desktop/tablet)
    double imageHeight = height * 0.15; // 15% of screen height

    if (width > 1200) {
      // Desktop
      cardWidth = width * 0.25;
      imageHeight = height * 0.2;
    } else if (width > 800) {
      // Tablet
      cardWidth = width * 0.3;
      imageHeight = height * 0.18;
    }

    return Container(
      height: height * 0.3,
      width: width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
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
                    // Image Container
                    Container(
                      height: imageHeight,
                      width: cardWidth,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        image: DecorationImage(
                          image: AssetImage(recipe['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Recipe Info
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              recipe['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.timer),
                              Text(
                                ' ${recipe['cookingTime']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Spacer(),
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              Text(
                                recipe['rating'].toString(),
                                style: const TextStyle(fontSize: 14),
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
  }
}

// class RecipeSlider extends StatelessWidget {
//   const RecipeSlider({super.key});

//   final List<Map<String, dynamic>> recipes = const [
//     {
//       'name': 'Pasta',
//       'image':
//           '/Users/ashnasathar/recipeApp/flutter_application_1/assets/blueberry_dessert.jpg',
//       'cookingTime': '30 mins',
//       'rating': 4.5,
//     },
//     {
//       'name': 'Pizza',
//       'image':
//           '/Users/ashnasathar/recipeApp/flutter_application_1/assets/prawns_curry.jpg',
//       'cookingTime': '40 mins',
//       'rating': 4.8,
//     },
//     {
//       'name': 'Burger',
//       'image':
//           '/Users/ashnasathar/recipeApp/flutter_application_1/assets/chilli_chicken.jpg',
//       'cookingTime': '20 mins',
//       'rating': 4.3,
//     },
//     {
//       'name': 'Salad',
//       'image':
//           '/Users/ashnasathar/recipeApp/flutter_application_1/assets/chicken_biriyani.jpg',
//       'cookingTime': '15 mins',
//       'rating': 4.2,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width;
//     final height = MediaQuery.sizeOf(context).height;

//     // Dynamic height for slider based on screen size

//     return Container(
//       color: Colors.orange,
//       height: height * .25,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: recipes.length,
//         itemBuilder: (context, index) {
//           final recipe = recipes[index];
//           return RecipeCard(recipe: recipe);
//         },
//       ),
//     );
//   }
// }

// class RecipeCard extends StatelessWidget {
//   final Map<String, dynamic> recipe;

//   const RecipeCard({super.key, required this.recipe});

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width;

//     // Dynamic width based on device type
//     double cardWidth = width * 0.4; // Default for mobile
//     if (width >= 1200) {
//       // Laptop or desktop
//       cardWidth = width * 0.2;
//     } else if (width >= 600) {
//       // Tablet
//       cardWidth = width * 0.3;
//     }

//     return Container(
//       width: cardWidth,
//       height: MediaQuery.sizeOf(context).height * .15,
//       margin: const EdgeInsets.only(right: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 4,
//             spreadRadius: 2,
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image - make height responsive too
//           ClipRRect(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(12)),
//               child: Image.asset(
//                 recipe['image'],
//                 height: cardWidth * 0.6,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               )),
//           Padding(
//             padding: EdgeInsets.all(cardWidth * 0.05), // Dynamic padding
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   recipe['name'],
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: cardWidth * 0.1, // Dynamic font size
//                   ),
//                 ),
//                 SizedBox(height: cardWidth * 0.02),
//                 Text(
//                   '⏱ ${recipe['cookingTime']}',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: cardWidth * 0.07,
//                   ),
//                 ),
//                 SizedBox(height: cardWidth * 0.02),
//                 Row(
//                   children: [
//                     const Icon(Icons.star, color: Colors.orange, size: 16),
//                     const SizedBox(width: 4),
//                     Text(
//                       recipe['rating'].toString(),
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
