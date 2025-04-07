import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';
import 'package:flutter_application_1/constants/text_style.dart';
import 'package:flutter_application_1/controller/login_controller.dart';
import 'package:flutter_application_1/view/admin/dashboard.dart';
import 'package:flutter_application_1/view/forget_password.dart';
import 'package:flutter_application_1/view/registration_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    validateAndSignIn() async {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all mandatory fields.")),
        );
      } else {
        bool success =
            await Provider.of<LoginController>(context, listen: false)
                .loginUser(emailController.text, passwordController.text);
        print("success is");
        print(success);
        if (success) {
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              context.pushReplacement('/nav-page/0');
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Provider.of<LoginController>(context, listen: false)
                      .errorMessage ??
                  "Login failed"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: Image.asset(
              '/Users/ashnasathar/recipeApp/flutter_application_1/assets/prowns.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Recipe",
                    style: TextStyles.h2.copyWith(
                      fontFamily: 'Sigmar',
                      letterSpacing: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "User name",
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: height * .03),
                  TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.black),
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ));
                        },
                        child: Text("Forgot Password?",
                            style: TextStyles.h6.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .03),
                  ElevatedButton(
                    onPressed: () {
                      if ((emailController.text == "admin@gmail.com") &&
                          (passwordController.text == "admin123")) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardAdmin(),
                            ));
                      } else {
                        validateAndSignIn();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: width * 0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Sign In", style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyles.h6.copyWith(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationPage(),
                              ));
                        },
                        child: Text("Sign Up",
                            style: TextStyles.h6.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
