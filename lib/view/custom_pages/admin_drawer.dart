import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/admin/feedback.dart';
import 'package:flutter_application_1/view/admin/user_page.dart';
import 'package:flutter_application_1/view/login_page.dart';
import 'package:flutter_application_1/view/splash_page.dart';
import 'package:go_router/go_router.dart';

class AdminDrawer extends StatelessWidget {
  final Function(String) onItemSelected;

  const AdminDrawer({Key? key, required this.onItemSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Admin"),
            accountEmail: Text("admin@example.com"),
            currentAccountPicture: CircleAvatar(),
          ),
          _buildDrawerItem(context, Icons.person, "User", "user"),
          Divider(),
          _buildDrawerItem(
              context, Icons.production_quantity_limits, "Items", "Items"),
          Divider(),
          _buildDrawerItem(
              context, Icons.subscriptions_outlined, "Feedbacks", "Feedbacks"),
          Divider(),
          _buildDrawerItem(context, Icons.logout, "Logout", "logout"),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        if (route == "Feedbacks") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FeedbackPage()),
          );
        } else if (route == "user") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserPage()),
          );
        } else if (route == "logout") {
          _showLogoutDialog(context);
        }
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
            child: Text("Logout"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
