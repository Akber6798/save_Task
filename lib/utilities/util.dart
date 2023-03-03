import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Util {
  showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void fieldFocusChange(
      BuildContext context,
      FocusNode currentFocus,
      FocusNode nextFocus) {
        currentFocus.unfocus();
        FocusScope.of(context).requestFocus(nextFocus);
      }
}
