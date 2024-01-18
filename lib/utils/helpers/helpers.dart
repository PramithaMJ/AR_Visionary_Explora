import 'package:flutter/material.dart';

class Helpers {
  /// Store all the helper method here
  /// 
  /// 
  static void navigateToPage(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}