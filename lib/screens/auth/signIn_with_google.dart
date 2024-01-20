import 'package:ar_visionary_explora/main/home/screeen/home.dart';
import 'package:ar_visionary_explora/utils/helpers/alert_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogle extends StatefulWidget {
  const SignInWithGoogle({super.key});

  @override
  State<SignInWithGoogle> createState() => _SignInWithGoogleState();
}

class _SignInWithGoogleState extends State<SignInWithGoogle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
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
