import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/view/edit_profile.dart';
import 'package:flutter_application_1/constants/color_constants.dart';
import 'package:flutter_application_1/controller/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<ProfileController>().fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.primaryColor,
            actions: [
              GestureDetector(
                onTap: () async {
                  final updatedData = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        name: controller.profile?.email ?? '',
                        email: controller.profile?.email ?? '',
                        dob: controller.profile?.dob ?? '',
                        mobile: controller.profile?.phone ?? '',
                        profileImage: controller.profile?.photoUrl ?? '',
                        password: '',
                      ),
                    ),
                  );
                  if (updatedData != null) {
                    controller.updateProfile(updatedData);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              double avatarRadius = screenWidth * 0.18;

              if (avatarRadius > 100) avatarRadius = 100;

              double fontSize = screenWidth < 400 ? 16 : 22;
              double padding = screenWidth < 400 ? 12 : 16;

              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.profile == null) {
                return const Center(child: Text("Failed to load profile"));
              }

              return Padding(
                padding: EdgeInsets.all(padding),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage: controller.profile!.photoUrl !=
                                      null &&
                                  controller.profile!.photoUrl!.isNotEmpty
                              ? FileImage(File(controller.profile!.photoUrl!))
                              : const AssetImage('assets/default_avatar.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          controller.profile!.email,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        buildProfileInfo(
                            Icons.email, controller.profile!.email, fontSize),
                        buildProfileInfo(Icons.calendar_today,
                            controller.profile!.dob, fontSize),
                        buildProfileInfo(
                            Icons.phone, controller.profile!.phone, fontSize),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildProfileInfo(IconData icon, String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: fontSize),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
