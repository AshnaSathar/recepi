import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/color_constants.dart';

class FeedbackUser extends StatefulWidget {
  const FeedbackUser({super.key});

  @override
  State<FeedbackUser> createState() => _FeedbackUserState();
}

class _FeedbackUserState extends State<FeedbackUser> {
  final TextEditingController _feedbackController = TextEditingController();
  int _rating = 0;

  void _submitFeedback() {
    String feedbackText = _feedbackController.text;

    if (feedbackText.isEmpty || _rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please provide feedback and a rating")),
      );
      return;
    }

    print("Feedback: $feedbackText, Rating: $_rating");

    _feedbackController.clear();
    setState(() {
      _rating = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Feedback submitted successfully")),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 32,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            "Give Feedback",
            style: TextStyle(
                fontFamily: 'Sigmar', color: ColorConstants.primaryColor),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Feedback",
              style: TextStyle(
                  fontSize: 18, fontFamily: 'Sigmar', color: Colors.white),
            ),
            SizedBox(height: 10),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white.withOpacity(.5),
                hintStyle: TextStyle(
                    fontFamily: 'Sigmar',
                    color: Colors.white,
                    fontWeight: FontWeight.w200),
                hintText: "Write your feedback here...",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Rate Us",
              style: TextStyle(
                  fontSize: 18, fontFamily: 'Sigmar', color: Colors.white),
            ),
            _buildStarRating(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitFeedback,
                child: Text("Submit Feedback"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: MediaQuery.sizeOf(context).width * 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
