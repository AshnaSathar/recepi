import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';
import 'package:flutter_application_1/controller/update_profile_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String dob;
  final String mobile;
  final String profileImage;
  final String password;

  const EditProfilePage(
      {super.key,
      required this.name,
      required this.email,
      required this.dob,
      required this.mobile,
      required this.profileImage,
      required this.password});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController dobController = TextEditingController();
  late TextEditingController mobileController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  File? _newProfileImage;
  String? _currentProfileImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    dobController = TextEditingController(text: widget.dob);
    mobileController = TextEditingController(text: widget.mobile);
    passwordController = TextEditingController(text: widget.password);

    _currentProfileImage = widget.profileImage;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _newProfileImage = File(pickedFile.path);
      });
    }
  }

  void saveProfile() async {
    bool success =
        await Provider.of<UpdateProfileController>(context, listen: false)
            .updateProfile(
                email: emailController.text,
                password: passwordController.text,
                dob: dobController.text,
                phone: mobileController.text,
                username: nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text("Edit Profile"),
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _newProfileImage != null
                        ? FileImage(_newProfileImage!) as ImageProvider
                        : (_currentProfileImage != null &&
                                _currentProfileImage!.isNotEmpty)
                            ? NetworkImage(_currentProfileImage!)
                            : const AssetImage('assets/default_profile.png')
                                as ImageProvider,
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildTextField("Name", nameController),
              buildTextField("Email", emailController),
              buildTextField("Date of Birth", dobController),
              buildTextField("Mobile Number", mobileController),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
