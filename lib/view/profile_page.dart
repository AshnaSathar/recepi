import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/edit_profile.dart';
import 'package:flutter_application_1/constants/color_constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Ashna Sathar";
  String email = "ashnasathar@gmail.com";
  String dob = "January 25, 2000";
  String mobile = "+91 8848687997";
  String profileImage =
      '/Users/ashnasathar/recipeApp/flutter_application_1/assets/AMP_imghappy-girl-taking-a-selfie_5f4a2e4438bf3.jpeg';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorConstants.primaryColor,
        actions: [
          GestureDetector(
            onTap: () async {
              final updatedData = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    name: name,
                    email: email,
                    dob: dob,
                    mobile: mobile,
                    profileImage: profileImage,
                  ),
                ),
              );

              if (updatedData != null) {
                setState(() {
                  name = updatedData["name"];
                  email = updatedData["email"];
                  dob = updatedData["dob"];
                  mobile = updatedData["mobile"];
                  profileImage = updatedData["profileImage"] ?? profileImage;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                "Edit Profile",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Just display the profile image, no tap functionality
              CircleAvatar(
                radius: screenWidth * 0.18,
                backgroundImage: profileImage.startsWith('assets/')
                    ? AssetImage(profileImage) as ImageProvider
                    : FileImage(File(profileImage)),
              ),
              const SizedBox(height: 16),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              buildProfileInfo(Icons.email, email),
              buildProfileInfo(Icons.calendar_today, dob),
              buildProfileInfo(Icons.phone, mobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
