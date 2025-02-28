import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';
import 'package:flutter_application_1/constants/text_style.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../controller/save_list_controller.dart'; // Adjust the path as needed

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final saveListController = Provider.of<SaveListController>(context);

    final savedRecipes = saveListController.savedRecipes;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: InkWell(
        //   onTap: () {
        //     context.go('/nav-page', extra: 0);
        //   },
        //   child: Icon(
        //     Icons.arrow_back,
        //     color: Colors.white,
        //   ),
        // ),
        backgroundColor: ColorConstants.primaryColor,
        title: Text(
          'Favourites',
          style: TextStyles.h5.copyWith(color: Colors.white),
        ),
      ),
      body: savedRecipes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      "/Users/ashnasathar/recipeApp/flutter_application_1/assets/empty.jpg"),
                  Text("Empty")
                ],
              ),
            )
          : ListView.builder(
              itemCount: savedRecipes.length,
              itemBuilder: (context, index) {
                final recipe = savedRecipes[index];
                return Dismissible(
                  key: Key(recipe['name']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    saveListController.removeRecipe(recipe['name']);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              '${recipe['name']} removed from favourites')),
                    );
                  },
                  child: InkWell(
                    onTap: () {
                      context.go('/product-details', extra: recipe);
                    },
                    child: Card(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            height: height * .15,
                            width: width * .35,
                            child: Image.asset(
                              recipe['image'],
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recipe['name'],
                                  style: TextStyles.normalText
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.timer_outlined),
                                      Text(recipe['cookingTime']),
                                      Spacer(),
                                      Icon(Icons.star, color: Colors.amber),
                                      Text(recipe['rating'].toString())
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
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
