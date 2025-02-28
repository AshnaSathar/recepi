import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';
import 'package:flutter_application_1/constants/text_style.dart';
import 'package:flutter_application_1/controller/items_controller.dart';
import 'package:flutter_application_1/controller/save_list_controller.dart';
import 'package:flutter_application_1/view/category_slide.dart';
import 'package:flutter_application_1/view/custom_drawer.dart';
import 'package:flutter_application_1/view/search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemsController>(context, listen: false).items;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        // leading: InkWell(
        //     onTap: () {
        //       //
        //       Scaffold.of(context).openEndDrawer();
        //       // Scaffold.openDrawer();
        //     },
        //     child: Icon(Icons.menu)),
        backgroundColor: Colors.white,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What would you like to cook today?",
                style: TextStyles.h2,
              ),
              SizedBox(height: height * 0.02),
              CustomSearchBar(
                controller: _searchController,
                onSearch: (value) {
                  print("Searching for: $value");
                  // Add your search logic if needed
                },
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Popular Recipes',
                style: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(child: RecipeSlider()),
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  Text(
                    'Recommended Recipes',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      context.go('/nav-page/1');

                      // context.go('/nav-page', extra: 1);
                    },
                    child: Text(
                      "See all",
                      style: TextStyles.normalText
                          .copyWith(color: ColorConstants.primaryColor),
                    ),
                  )
                ],
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: Consumer<ItemsController>(
                  builder: (context, controller, child) {
                    if (controller.items.isEmpty) {
                      return Center(child: Text("No recipes available"));
                    }

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: controller.items.length,
                      itemBuilder: (context, index) {
                        var recipe = controller.items[index];
                        return InkWell(
                          onTap: () {
                            context.go('/product-details', extra: recipe);
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 4,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recipe['name'],
                                        style: TextStyles.normalText.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.timer_outlined),
                                            Text(recipe['cookingTime']),
                                            Spacer(),
                                            Icon(Icons.star,
                                                color: Colors.amber),
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
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
