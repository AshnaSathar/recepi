import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> feedbackList = [
      {
        "name": "Ashna Fasal",
        "feedback": "Great service and fast response!",
        "rating": 5
      },
      {
        "name": "Rahul Ramesh",
        "feedback": "User interface could be improved.",
        "rating": 3
      },
      {
        "name": "Sneha Raj",
        "feedback": "Loved the experience, will recommend!",
        "rating": 4
      },
      {
        "name": "Manoj Kumar",
        "feedback": "Had some issues, but support helped quickly.",
        "rating": 4
      },
      {
        "name": "Neha Sharma",
        "feedback": "Needs more features, but overall good.",
        "rating": 3
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text("User Feedback")),
      body: ListView.builder(
        itemCount: feedbackList.length,
        itemBuilder: (context, index) {
          final feedback = feedbackList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feedback["name"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(feedback["feedback"]),
                  SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      5,
                      (starIndex) => Icon(
                        Icons.star,
                        color: starIndex < feedback["rating"]
                            ? Colors.amber
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
