import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';
import 'package:flutter_application_1/constants/text_style.dart';
import 'package:flutter_application_1/controller/login_controller.dart';
import 'package:flutter_application_1/controller/register_controller.dart';
import 'package:flutter_application_1/view/login_page.dart';
import 'package:flutter_application_1/view/terms_and_privacy.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool status = false;

  void _register() async {
    final String email = _emailController.text.trim();
    final String username = _usernameController.text.trim();
    final String dob = _dobController.text.trim();
    final String phone = _phoneController.text.trim();
    final String password = _passwordController.text.trim();

    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z][a-zA-Z0-9._]*$');
    final RegExp passwordRegex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

    if (username.isEmpty ||
        password.isEmpty ||
        dob.isEmpty ||
        email.isEmpty ||
        phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all mandatory fields.")),
      );
      return;
    }
    if (!usernameRegex.hasMatch(username)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Invalid username. Must start with a letter."),
            backgroundColor: Colors.red),
      );
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Invalid email format."),
            backgroundColor: Colors.red),
      );
      return;
    }

    if (!phoneRegex.hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Invalid phone number. Must be 10 digits."),
            backgroundColor: Colors.red),
      );
      return;
    }

    if (!passwordRegex.hasMatch(password)) {
      print(password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "Password must be at least 8 characters and contain both letters and numbers."),
            backgroundColor: Colors.red),
      );
      return;
    }

    DateTime? dobDate;
    try {
      dobDate = DateTime.parse(dob);
      int age = DateTime.now().year - dobDate.year;
      if (DateTime.now().month < dobDate.month ||
          (DateTime.now().month == dobDate.month &&
              DateTime.now().day < dobDate.day)) {
        age--;
      }
      if (age < 18) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("You must be at least 18 years old to register."),
              backgroundColor: Colors.red),
        );
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Invalid date format. Use YYYY-MM-DD."),
            backgroundColor: Colors.red),
      );
      return;
    }

    bool success = await Provider.of<RegisterController>(context, listen: false)
        .registerUser(
      phone: phone,
      dob: dob,
      email: email,
      password: password,
      username: username,
      context: context,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registered successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.pop(context);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Provider.of<RegisterController>(context, listen: false)
                  .errorMessage ??
              "Registration failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            child: Image.asset(
              "/Users/ashnasathar/recipeApp/flutter_application_1/assets/842ce55b61c16711096032be814c4579.jpg",
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.15),
                  Text(
                    "Recipe App",
                    style: TextStyles.h2.copyWith(
                      fontFamily: 'Sigmar',
                      letterSpacing: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "We craft recipes that melt your ",
                        style: TextStyles.h6.copyWith(color: Colors.white),
                      ),
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.1),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "User Name",
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _phoneController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.phone, color: Colors.white),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _dobController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date of birth *",
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:
                          const Icon(Icons.calendar_today, color: Colors.white),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dobController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:
                          const Icon(Icons.password, color: Colors.white),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = !status;
                          });
                        },
                      ),
                      const Text(
                        "By clicking you accept our ",
                        style: TextStyle(color: Colors.white),
                      ),
                      _buildClickableText("Terms and Privacy", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TermsAndPrivacy()),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _register,
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(ColorConstants.primaryColor),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableText(String text, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
