import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';
import 'package:flutter_application_1/constants/text_style.dart';

class TermsAndPrivacy extends StatefulWidget {
  const TermsAndPrivacy({super.key});

  @override
  State<TermsAndPrivacy> createState() => _TermsAndPrivacyState();
}

class _TermsAndPrivacyState extends State<TermsAndPrivacy> {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Terms & Privacy Policy',
          style: TextStyles.h6.copyWith(
            fontFamily: 'Sigmar',
            letterSpacing: 2,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Welcome to Recipe App! By using our app, you agree to comply with and be bound by the following terms and conditions. Please review these terms carefully.",
                  style: TextStyles.normalText.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),
                _bulletPoint(
                    "You must be at least 13 years old to use this app."),
                _bulletPoint(
                    "You are responsible for all activity occurring under your account."),
                _bulletPoint(
                    "Do not misuse our services or interfere with the app's functionality."),
                _bulletPoint(
                    "We reserve the right to terminate accounts that violate our terms."),
                const SizedBox(height: 24),
                const Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Your privacy is important to us. This policy explains how we collect, use, and protect your information.",
                  style: TextStyles.normalText.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),
                _bulletPoint(
                    "We collect information you provide, such as your name, email, and profile photo."),
                _bulletPoint(
                    "We use this data to personalize your experience and improve our services."),
                _bulletPoint(
                    "We do not share your data with third parties without your consent, except as required by law."),
                _bulletPoint(
                    "You can delete your account and data anytime from the app settings."),
                const SizedBox(height: 24),
                const Text(
                  "Changes to Terms & Privacy",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "We may update these terms and our privacy policy from time to time. Users will be notified of any significant changes.",
                  style: TextStyles.normalText.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Contact Us",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "If you have any questions, please contact us at support@recipeapp.com.",
                  style: TextStyles.normalText.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyles.normalText.copyWith(color: Colors.white),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyles.normalText.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
