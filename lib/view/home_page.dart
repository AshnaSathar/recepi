import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';
import 'package:flutter_application_1/constants/text_style.dart';
import 'package:flutter_application_1/controller/items_controller.dart';
import 'package:flutter_application_1/view/category_slide.dart';
import 'package:flutter_application_1/view/custom_drawer.dart';
import 'package:flutter_application_1/view/search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Responsive font size helper function
double getResponsiveFontSize(double baseSize, BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth > 1000) {
    return baseSize * 1.4; // Larger text for large screens (like tablets)
  } else if (screenWidth > 600) {
    return baseSize * 1.2; // Medium size for tablets
  } else {
    return baseSize; // Default for phones
  }
}

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
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth;
            double height = constraints.maxHeight;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What would you like to cook today?",
                      style: TextStyles.h2.copyWith(
                        fontSize: getResponsiveFontSize(20, context),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    CustomSearchBar(
                      controller: _searchController,
                      onSearch: (value) {
                        print("Searching for: $value");
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Popular Recipes',
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(18, context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    const RecipeSlider(),
                    SizedBox(height: height * 0.03),
                    Row(
                      children: [
                        Text(
                          'Recommended Recipes',
                          style: TextStyle(
                            fontSize: getResponsiveFontSize(18, context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            context.go('/nav-page/1');
                          },
                          child: Text(
                            "See all",
                            style: TextStyles.normalText.copyWith(
                              fontSize: getResponsiveFontSize(14, context),
                              color: ColorConstants.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Consumer<ItemsController>(
                      builder: (context, controller, child) {
                        if (controller.items.isEmpty) {
                          return const Center(
                              child: Text("No recipes available"));
                        }

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
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
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height * 0.15,
                                        width: width * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: AssetImage(recipe['image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recipe['name'],
                                              style: TextStyles.normalText
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: getResponsiveFontSize(
                                                    16, context),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                const Icon(Icons.timer_outlined,
                                                    size: 16),
                                                const SizedBox(width: 4),
                                                Text(
                                                  recipe['cookingTime'],
                                                  style: TextStyle(
                                                    fontSize:
                                                        getResponsiveFontSize(
                                                            12, context),
                                                  ),
                                                ),
                                                const Spacer(),
                                                const Icon(Icons.star,
                                                    color: Colors.amber,
                                                    size: 16),
                                                Text(
                                                  recipe['rating'].toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        getResponsiveFontSize(
                                                            12, context),
                                                  ),
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
