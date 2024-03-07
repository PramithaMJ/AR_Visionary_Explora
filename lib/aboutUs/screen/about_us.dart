// Import the necessary packages
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// About Us Page
class AboutUsPage extends StatelessWidget {
  // Email address
  final String emailAddress = 'arvisionaryexplorer@example.com';
  // Open email app
  void _launchEmail() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );

    try {
      if (await canLaunch(_emailLaunchUri.toString())) {
        await launch(_emailLaunchUri.toString());
      } else {
        throw 'Could not launch email. Make sure an email app is installed.';
      }
    } catch (e) {
      // ad toast  message
      print('Error launching email: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AR Visionary Explorer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We are Group No: 51, consisting of members:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '1. Abeysekara P.K.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '2. Jayasooriya L.P.M.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'AR Visionary Explorer is a mobile application that brings the world of augmented reality to furniture shopping...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _launchEmail,
              child: Text(
                'Email: $emailAddress',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
