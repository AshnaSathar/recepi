import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/custom_pages/admin_drawer.dart';
import 'package:flutter_application_1/view/login_page.dart';
import 'package:flutter_application_1/view/splash_page.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  String selectedPage = "Dashboard";

  void _onDrawerItemSelected(String page) {
    setState(() {
      selectedPage = page;
    });

    if (page == "logout") {
      _showLogoutDialog();
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(selectedPage)),
      drawer: AdminDrawer(
        onItemSelected: _onDrawerItemSelected,
      ),
      body: Center(
        child: Text(
          "Welcome to $selectedPage",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
