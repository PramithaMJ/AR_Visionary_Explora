import 'package:animate_do/animate_do.dart';
import 'package:ar_visionary_explora/components/app_logo.dart';
import 'package:ar_visionary_explora/components/common_back_button.dart';
import 'package:ar_visionary_explora/components/custom_text.dart';
import 'package:ar_visionary_explora/components/custom_textfield.dart';
import 'package:ar_visionary_explora/components/cutomer_button.dart';
import 'package:ar_visionary_explora/components/social_button.dart';
import 'package:ar_visionary_explora/main/home/screeen/home.dart';
import 'package:ar_visionary_explora/providers/auth_provider.dart'
    as MyAppAuthProvider;
import 'package:ar_visionary_explora/screens/auth/onboarding_facebook_auth.dart';
import 'package:ar_visionary_explora/utils/constants/app_assets.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:ar_visionary_explora/screens/auth/fogot_password.dart';
import 'package:ar_visionary_explora/utils/helpers/alert_helpers.dart';
import 'package:ar_visionary_explora/utils/helpers/helpers.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // //email textfiled controller
  // final TextEditingController _email = TextEditingController();
  // // password textfiled controller
  // final TextEditingController _password = TextEditingController();
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
                const Align(
                  alignment: Alignment.topLeft,
                  child: CommonBackButton(),
                ),
                const CustomText(
                  "Login",
                  fontSize: 25,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                const AppLogo(),
                const SizedBox(
                  height: 10,
                ),
                CustomerTextField(
                  hintText: "Enter your Email",
                  labelText: "Email",
                  controller:
                      Provider.of<MyAppAuthProvider.AuthProvider>(context)
                          .loginEmail,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomerTextField(
                  hintText: "Enter your Password",
                  labelText: "Password",
                  isObscure: true,
                  controller:
                      Provider.of<MyAppAuthProvider.AuthProvider>(context)
                          .loginPassword,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FogotPassword()),
                      );
                    },
                    child: const Text(
                      "Fogot your password?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Consumer<MyAppAuthProvider.AuthProvider>(
                  builder: (context, value, child) => CustomButton(
                    text: "Login",
                    isLoading: value.isLoading,
                    onTap: () {
                      value.startLogin(context);
                    },
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                const CustomText(
                  "or login with social account",
                  fontSize: 14,
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     _signInWithGoogle();
                    //   },
                    //   child: SocialButton(
                    //     path: AppAssets.google,
                    //     onTap: () {},
                    //   ),
                    // ),
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    // SocialButton(
                    //   path: AppAssets.fb,
                    //   onTap: () {},
                    // ),
                    // SignInButton(
                    //   Buttons.google,
                    //   text: "Sign up with Google",
                    //   onPressed: () {
                    //     _signInWithGoogle();
                    //   },
                    // ),

                    GoogleAuthButton(
                      onPressed: () {
                        _signInWithGoogle();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    FacebookAuthButton(
                      onPressed: () {
                        _signInWithGoogle();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GithubAuthButton(
                      onPressed: () {
                        _signInWithGoogle();
                      },
                    ),

                    // ElevatedButton(
                    //   onPressed: () {
                    //     _signInWithGoogle();
                    //   },
                    //   child: Text("G Login"),
                    // ),
                    //FacebookAuthentication(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        // await _firebaseAuth.signInWithCredential(credential);
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      //show toast
      AlertHelpers.showAlert(context, "Something went wrong");
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }
}
