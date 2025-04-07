import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';
import 'package:flutter_application_1/constants/text_style.dart';
import 'package:flutter_application_1/controller/save_list_controller.dart';
import 'package:provider/provider.dart';

class ItemRecipe extends StatefulWidget {
  final recipe;

  const ItemRecipe({super.key, required this.recipe});

  @override
  State<ItemRecipe> createState() => _ItemRecipe();
}

class _ItemRecipe extends State<ItemRecipe> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    final saveListController = context.read<SaveListController>();
    isSaved = saveListController.isRecipeSaved(widget.recipe.name);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: height * .4,
                color: const Color.fromARGB(255, 226, 225, 225),
              ),
              Positioned(
                  left: 02,
                  child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back))),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  onPressed: toggleSave,
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipe.name,
                  style: TextStyles.h6,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: const Color.fromARGB(255, 0, 112, 4),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${widget.recipe.prepTime} min",
                      style: TextStyles.normalText
                          .copyWith(color: ColorConstants.primaryColor),
                    ),
                    Spacer(),
                    Text(
                      widget.recipe.cuisine,
                      style: TextStyles.normalText
                          .copyWith(color: ColorConstants.primaryColor),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tab(
                    child: Text(
                      "Description",
                      style: TextStyles.h6,
                    ),
                  ),
                  Text(
                    widget.recipe.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10),
                  Tab(
                    child: Text(
                      "Instruction",
                      style: TextStyles.h6,
                    ),
                  ),
                  Text(
                    widget.recipe.instructions,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
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
}
