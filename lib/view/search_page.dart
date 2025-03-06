import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/items_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/constants/color_constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = [];
  }

  void _filterItems(String query) {
    final itemsController =
        Provider.of<ItemsController>(context, listen: false);

    setState(() {
      if (query.isEmpty) {
        filteredItems = [];
      } else {
        filteredItems = itemsController.items.where((item) {
          return item['ingredients'].any((ingredient) => ingredient
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()));
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search items by ingredient...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (query) {
                _filterItems(query);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(child: Text('No items found'))
                  : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return ListTile(
                          leading: Image.asset(item['image'],
                              width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(item['name']),
                          subtitle: Text(
                              'Cooking Time: ${item['cookingTime']} - Rating: ${item['rating']} ⭐'),
                          onTap: () {
                            _showRecipeDetails(context, item);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRecipeDetails(BuildContext context, Map<String, dynamic> recipe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(recipe['name']),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ingredients:"),
              ...recipe['ingredients']
                  .map<Widget>((ing) => Text("- $ing"))
                  .toList(),
              const SizedBox(height: 8),
              const Text("Cooking Method:"),
              ...recipe['cookingMethod']
                  .map<Widget>((step) => Text("- $step"))
                  .toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close")),
        ],
      ),
    );
  }
}
