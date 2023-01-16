import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showWarningToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      timeInSecForIosWeb: 3);
}

void showToast(String text) {
  Fluttertoast.showToast(msg: text, timeInSecForIosWeb: 3);
}
