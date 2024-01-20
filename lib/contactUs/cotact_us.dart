import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Have questions or suggestions?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Feel free to reach out to us. We are here to help!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Group Members:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Pramitha M.J.',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text('GitHub: @PramithaMJ'),
              onTap: () {
                _launchURL('https://github.com/PramithaMJ');
              },
            ),
            ListTile(
              title: Text(
                'Pasan Abeysekara',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text('GitHub: @PasanAbeysekara'),
              onTap: () {
                _launchURL('https://github.com/PasanAbeysekara');
              },
            ),
            SizedBox(height: 20),
            Text(
              'Email Us:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Pramitha M.J.',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text('Email: lpramithamj@gmail.com'),
              onTap: () {
                _launchEmail('lpramithamj@gmail.com');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch $_emailLaunchUri';
    }
  }
}
