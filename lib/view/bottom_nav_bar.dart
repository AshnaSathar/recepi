import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int) onTabTapped;

  const BottomNavBar({
    super.key,
    required this.onTabTapped,
    required int currentIndex, // Pass the function to handle tab changes
  });

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: Colors.white,
      color: ColorConstants.primaryColor,
      activeColor: Colors.orange, // Highlight color when tab is active
      style: TabStyle.react, // Looks better for food apps
      items: const [
        TabItem(
          icon: Icons.home,
          title: 'Home',
        ),
        TabItem(
          icon: Icons.category,
          title: 'Categories',
        ),
        TabItem(
          icon: Icons.favorite,
          title: 'Favorites',
        ),
        TabItem(
          icon: Icons.person,
          title: 'Profile',
        ),
      ],
      onTap: onTabTapped, // Call the parent function when tapping a tab
    );
  }
}
