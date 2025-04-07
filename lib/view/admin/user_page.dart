import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // Hardcoded user list
  final List<Map<String, String>> users = [
    {"name": "Sama Razi", "email": "sama@example.com", "role": "User"},
    {"name": "Rahul Ramesh", "email": "rahul@example.com", "role": "User"},
    {"name": "Sneha Raj", "email": "sneha@example.com", "role": "User"},
    {"name": "Manoj Kumar", "email": "manoj@example.com", "role": "User"},
    {"name": "Neha Sharma", "email": "neha@example.com", "role": "User"},
    {"name": "Rahul Ramesh", "email": "rahul@example.com", "role": "User"},
    {"name": "Sneha Raj", "email": "sneha@example.com", "role": "User"},
    {"name": "Manoj Kumar", "email": "manoj@example.com", "role": "User"},
    {"name": "Neha Sharma", "email": "neha@example.com", "role": "User"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(child: Text(user["name"]![0])),
              title: Text(user["name"]!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(user["email"]!),
              trailing:
                  Text(user["role"]!, style: TextStyle(color: Colors.blue)),
            ),
          );
        },
      ),
    );
  }
}
