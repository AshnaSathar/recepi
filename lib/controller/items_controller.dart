import 'package:flutter/material.dart';

class ItemsController extends ChangeNotifier {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Blueberry Cake',
      'image': 'assets/blueberry_dessert.jpg',
      'cookingTime': '30 mins',
      'rating': 4.5,
      'ingredients': [
        '1 cup all-purpose flour',
        '1/2 cup sugar',
        '1/2 cup butter',
        '2 eggs',
        '1 tsp baking powder',
        '1/2 cup milk',
        '1 tsp vanilla extract',
        '1 cup blueberries',
      ],
      'cookingMethod': [
        'Preheat oven to 180°C.',
        'Cream butter and sugar together.',
        'Add eggs and vanilla, mix well.',
        'Sift flour and baking powder, add to the mixture alternately with milk.',
        'Fold in blueberries.',
        'Pour batter into a greased pan.',
        'Bake for 25-30 minutes until golden brown.',
      ],
      'recipe':
          'A soft and moist cake bursting with fresh blueberries. Perfect for tea time or dessert.'
    },
    {
      'name': 'Prawns Curry',
      'image': 'assets/prawns_curry.jpg',
      'cookingTime': '40 mins',
      'rating': 4.8,
      'ingredients': [
        '500g prawns, cleaned',
        '2 onions, chopped',
        '2 tomatoes, chopped',
        '4 cloves garlic, minced',
        '1 inch ginger, minced',
        '1 tsp turmeric powder',
        '1 tsp red chili powder',
        '1 tsp garam masala',
        '1 cup coconut milk',
        '2 tbsp oil',
        'Salt to taste',
        'Curry leaves'
      ],
      'cookingMethod': [
        'Heat oil in a pan, sauté onions, garlic, and ginger until golden.',
        'Add tomatoes and cook till soft.',
        'Add turmeric, chili powder, and salt. Cook till oil separates.',
        'Add prawns and cook for 5 minutes.',
        'Pour in coconut milk and simmer for 10 minutes.',
        'Sprinkle garam masala and garnish with curry leaves.',
      ],
      'recipe':
          'A flavorful coastal dish with tender prawns cooked in a rich coconut curry sauce.'
    },
    {
      'name': 'Chilli Chicken',
      'image': 'assets/chilli_chicken.jpg',
      'cookingTime': '20 mins',
      'rating': 4.3,
      'ingredients': [
        '500g chicken, cubed',
        '2 tbsp soy sauce',
        '1 tbsp vinegar',
        '1 tbsp ginger-garlic paste',
        '2 tbsp cornflour',
        '1 capsicum, sliced',
        '1 onion, sliced',
        '2 green chilies, sliced',
        '2 tbsp tomato sauce',
        '1 tbsp chili sauce',
        'Oil for frying',
        'Spring onions for garnish'
      ],
      'cookingMethod': [
        'Marinate chicken with soy sauce, vinegar, ginger-garlic paste, and cornflour.',
        'Fry the chicken until crispy and set aside.',
        'In a pan, sauté onions, capsicum, and green chilies.',
        'Add tomato sauce, chili sauce, and fried chicken.',
        'Toss well and garnish with spring onions.'
      ],
      'recipe':
          'A spicy Indo-Chinese delight with crispy fried chicken tossed in a tangy sauce.'
    },
    {
      'name': 'Chicken Biriyani',
      'image': 'assets/chicken_biriyani.jpg',
      'cookingTime': '15 mins',
      'rating': 4.2,
      'ingredients': [
        '500g chicken',
        '2 cups basmati rice',
        '2 onions, sliced',
        '2 tomatoes, chopped',
        '1/2 cup yogurt',
        '1 tbsp ginger-garlic paste',
        'Whole spices (bay leaf, cinnamon, cloves)',
        '1 tsp biriyani masala',
        '2 tbsp ghee',
        'Salt to taste',
        'Coriander and mint leaves'
      ],
      'cookingMethod': [
        'Fry onions till golden brown, remove half for garnish.',
        'Sauté whole spices, ginger-garlic paste, and tomatoes.',
        'Add chicken, yogurt, biriyani masala, and cook till done.',
        'Layer rice and chicken in a pot.',
        'Top with fried onions, coriander, and mint.',
        'Cover and cook on low for 10 mins.',
      ],
      'recipe':
          'A rich, aromatic rice dish layered with tender spiced chicken and fragrant basmati rice.'
    },
  ];
}
