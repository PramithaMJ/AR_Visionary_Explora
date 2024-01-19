import 'package:animate_do/animate_do.dart';
import 'package:ar_visionary_explora/components/app_logo.dart';
import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/components/custom_textfield.dart';
import 'package:ar_visionary_explora/components/cutomer_button.dart';
import 'package:ar_visionary_explora/controllers/auth_controller.dart';
import 'package:ar_visionary_explora/providers/auth_provider.dart';
import 'package:ar_visionary_explora/screens/auth/login.dart';
import 'package:ar_visionary_explora/utils/helpers/alert_helpers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_colors.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  "SignUp",
                  fontSize: 25,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 41,
                ),
                const AppLogo(),
                const SizedBox(
                  height: 30,
                ),
                CustomerTextField(
                  hintText: "Enter your UserName",
                  labelText: "Username",
                  controller: Provider.of<AuthProvider>(context).userName,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomerTextField(
                  hintText: "Enter your Email",
                  labelText: "Email",
                  controller: Provider.of<AuthProvider>(context).email,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomerTextField(
                  hintText: "Enter your Password",
                  labelText: "Password",
                  isObscure: _obscurePassword,
                  controller: Provider.of<AuthProvider>(context).password,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    // CustomerTextField(
                    //   hintText: "Enter your Password",
                    //   labelText: "Password",
                    //   isObscure: _obscurePassword,
                    //   controller:
                    //       Provider.of<AuthProvider>(context).loginPassword,
                    // ),
                    const SizedBox(height: 10),
                    CustomerTextField(
                      hintText: "Re-enter your Password",
                      labelText: "Re-enter Password",
                      isObscure: _obscurePassword,
                      controller:
                          Provider.of<AuthProvider>(context).reEnterPassword,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      label: Text(
                          _obscurePassword ? 'Show Password' : 'Hide Password'),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: const Text(
                      "Already have an account?",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    return CustomButton(
                      text: "Sign up",
                      isLoading: value.isLoading,
                      onTap: () {
                        value.startSignup(context);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
