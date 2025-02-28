import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';
import 'package:flutter_application_1/constants/text_style.dart';
import 'package:flutter_application_1/view/emailBottom.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void validateAndSignIn() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter a valid email address!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      context.go('/nav-page/0');
    }

    print("Signing in with Email: $email, Password: $password");
  }

  @override
  Widget build(BuildContext context) {
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
                      labelText: "Email",
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
                          context.push('/forgot-password');
                        },
                        child: Text("Forgot Password?",
                            style: TextStyles.h6.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),

                      // TextButton(
                      //   onPressed: () {
                      //     context.push('/sign-up');
                      //   },
                      //   child: Text("Sign Up",
                      //       style: TextStyles.h6.copyWith(
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.white)),
                      // ),
                    ],
                  ),
                  SizedBox(height: height * .03),
                  ElevatedButton(
                    onPressed: validateAndSignIn,
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
                          showEmailVerificationBottomSheet(context);
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
