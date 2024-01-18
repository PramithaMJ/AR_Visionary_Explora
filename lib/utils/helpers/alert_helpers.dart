import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AlertHelpers {
  /// shows a dialog
  ///
  static void showAlert(BuildContext context, String desc, {DialogType type = DialogType.error}) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.rightSlide,
      title: type == DialogType.success? "Success":' Error',
      desc: desc,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }
}
