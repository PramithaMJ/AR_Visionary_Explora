import 'package:ar_visionary_explora/components/custom_textfield.dart';
import 'package:ar_visionary_explora/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileUpdateForm extends StatefulWidget {
  @override
  _ProfileUpdateFormState createState() => _ProfileUpdateFormState();
}

class _ProfileUpdateFormState extends State<ProfileUpdateForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomerTextField(
            hintText: "New Username",
            labelText: "New Username",
            controller: _usernameController,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              authProvider.updateUserProfile(context, _usernameController.text);
            },
            child: const Text('Update Profile'),
          ),
          const SizedBox(
            height: 10,
          ),
          // Old Password field
          CustomerTextField(
            hintText: "Old Password",
            labelText: "Old Password",
            isObscure: true,
            controller: _oldPasswordController,
          ),
          const SizedBox(
            height: 10,
          ),

          // New Password field
          CustomerTextField(
            hintText: "New Password",
            labelText: "New Password",
            isObscure: true,
            controller: _newPasswordController,
          ),
          const SizedBox(
            height: 10,
          ),
          // Reset Password Button
          ElevatedButton(
            onPressed: () {
              authProvider.oldPassword.text = _oldPasswordController.text;
              authProvider.newPassword.text = _newPasswordController.text;
              authProvider.resetPassword(context);
            },
            child: const Text('Reset Password'),
          ),
        ],
      ),
    );
  }
}
