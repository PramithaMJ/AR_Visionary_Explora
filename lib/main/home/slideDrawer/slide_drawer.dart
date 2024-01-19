import 'package:ar_visionary_explora/providers/auth_provider.dart';
import 'package:ar_visionary_explora/aboutUs/screen/about_us.dart';
import 'package:ar_visionary_explora/utils/constants/app_assets.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userModel = authProvider.userModel;

    return Drawer(
      child: Column(
        children: <Widget>[
          // User Profile Header
          UserAccountsDrawerHeader(
            accountName: Text(userModel?.userName ?? "No Name"),
            accountEmail: Text(userModel?.email ?? "No Email"),
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  NetworkImage(userModel?.img ?? AppAssets.profileUrl),
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 224, 144, 104),
            ),
          ),

          // Drawer Body
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('AR View'),
                  onTap: () {
                    // Handle tap
                  },
                ),
                ListTile(
                  title: Text('About Us'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => AboutUsPage()));
                  },
                ),
                ListTile(
                  title: Text('Contact Us'),
                  onTap: () {
                    // Handle tap
                  },
                ),
                ListTile(
                  title: Text('Terms & Conditions'),
                  onTap: () {
                    // Handle tap
                  },
                ),
                ListTile(
                  title: Text('Settings'),
                  onTap: () {
                    // Handle tap
                  },
                ),
                // Add more items here
              ],
            ),
          ),

          // Sign out option
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: ListTile(
              title: Text('Sign Out'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                authProvider.logOut();
                Navigator.of(context).pop(); // close the drawer
              },
            ),
          ),
        ],
      ),
    );
  }
}
