import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Introduction',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to AR Visionary Explorer!',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Acceptance of Terms',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'By using AR Visionary Explorer, you agree to comply with and be bound by these Terms and Conditions.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'User Responsibilities',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '1. You are responsible for maintaining the confidentiality of your account credentials.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '2. You agree not to use the app for any unlawful purpose or in violation of any applicable laws.',
                style: TextStyle(fontSize: 18),
              ),
              // Add more user responsibilities as needed
              SizedBox(height: 20),
              Text(
                'Intellectual Property',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'All content and features of the app are protected by intellectual property laws.',
                style: TextStyle(fontSize: 18),
              ),
              // Add more sections based on your app's features and policies
              SizedBox(height: 20),
              Text(
                'Changes to Terms and Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'We reserve the right to modify these Terms and Conditions at any time. You are responsible for regularly reviewing these terms.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'If you have any questions or concerns about these Terms and Conditions, please contact us at arvisionaryexplorer@example.com.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
