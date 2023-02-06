import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(
  String message, {
  Toast? toastLength,
}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    textColor: Colors.white,
    backgroundColor: Colors.grey[600],
    gravity: ToastGravity.BOTTOM,
    toastLength: toastLength ?? Toast.LENGTH_LONG,
  );
}
