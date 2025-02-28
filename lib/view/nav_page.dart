import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/bottom_nav_bar.dart';
import 'package:flutter_application_1/view/categories_page.dart';
import 'package:flutter_application_1/view/favourite_page.dart';
import 'package:flutter_application_1/view/home_page.dart';

import 'package:flutter_application_1/view/profile_page.dart';
import 'package:go_router/go_router.dart';

class NavPage extends StatefulWidget {
  final int index;
  const NavPage({super.key, required this.index});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final List<Widget> _pages = [
    HomePage(),
    CategoriesPage(),
    FavouritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.index;

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavBar(
        onTabTapped: (index) {
          context.go('/nav-page/$index');
        },
        currentIndex: currentIndex,
      ),
    );
  }
}
