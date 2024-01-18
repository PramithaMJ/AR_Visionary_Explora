import 'dart:io';

import 'package:ar_visionary_explora/controllers/file_upload_controller.dart';
import 'package:ar_visionary_explora/models/user_model.dart';
import 'package:ar_visionary_explora/utils/constants/app_assets.dart';
import 'package:ar_visionary_explora/utils/helpers/alert_helpers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthConroller {
  /// Sign in user function

  Future<void> signupUser(BuildContext context, String email, String password,
      String userName) async {
    try {
      // sent the email and password to firebase and try to create a user
      // final credential =
      //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((credential) {
        if (credential.user!.email != null) {
          Logger().w(credential);
          // Navigator.pushReplacementNamed(context, '/home');
          Logger().w("User created successfully");
          // if success save the user data to firebase
          saveUserData(email, userName, credential.user!.uid);
        } else {
          Logger().w("User not created successfully");
        }
      });
    } on FirebaseAuthException catch (e) {
      AlertHelpers.showAlert(context, e.code);
    } catch (e) {
      AlertHelpers.showAlert(context, e.toString());
    }
  }

// create a collection reference called users
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// save extra user data to firebase
  Future<void> saveUserData(String email, String userName, String uid) async {
    return users
        .doc(uid)
        .set({
          'uid': uid,
          'userName': userName,
          'email': email,
          'img': AppAssets.profileUrl,
        })
        .then((value) => Logger().i("User Added"))
        .catchError((error) => Logger().e("Failed to add user: $error"));
  }

  /// --- Login User Function ---
  Future<void> loginUser(
    BuildContext context,
    String loginEmail,
    String loginPassword,
  ) async {
    try {
      // sent the email and password to firebase and try to create a user
      // final credential =
      //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: loginEmail,
        password: loginPassword,
      )
          .then((credential) {
        Logger().w(credential);
      });
    } on FirebaseAuthException catch (e) {
      AlertHelpers.showAlert(context, e.code);
    } catch (e) {
      AlertHelpers.showAlert(context, e.toString());
    }
  }

  /// --- send password reset Email Function ---
  Future<void> sendEmail(
    BuildContext context,
    String email,
  ) async {
    try {
      // sent the email and password to firebase and try to create a user
      // final credential =
      //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

      await FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: email,
      )
          .then((value) {
        AlertHelpers.showAlert(context, "Email sent to your inbox",
            type: DialogType.success);
      });
    } on FirebaseAuthException catch (e) {
      AlertHelpers.showAlert(context, e.code);
    } catch (e) {
      AlertHelpers.showAlert(context, e.toString());
    }
  }

  /// --- Fetch userData from cloud firestore ---
  Future<UserModel?> fetchUserData(
    BuildContext context,
    String uid,
  ) async {
    try {
      // Firebase Query find and fetch user data accourding to uid
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();

      if (documentSnapshot.exists) {
        Logger().w(documentSnapshot.data());
        // Mapping fetch data to user model
        UserModel model =
            UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
        return model;
      } else {
        Logger().e("No data found");
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  final FileUploadController _fileUploadController = FileUploadController();

  // upload pick image file to the firebase storage bucket and update the user profile
  Future<String> uploadAndUpdateProfileImage(File file, String uid) async {
    try {
      // start uplaoding the file
      final String downloadUrl = await _fileUploadController.uploadFile(
        file,
        "userImages",
      );

      // check if the file is uploaded
      if (downloadUrl.isNotEmpty) {
        await users.doc(uid).update({
          "img": downloadUrl,
        });
        return downloadUrl;
      } else {
        Logger().w("download url is empty");
        return "";
      }
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }
}
