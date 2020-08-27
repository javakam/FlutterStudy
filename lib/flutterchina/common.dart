import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(text) => toastOriginal(text, ToastGravity.CENTER);

void toastTop(text) => toastOriginal(text, ToastGravity.TOP);

void toastOriginal(String text, ToastGravity gravity) {
  //Toast with No Build Context
  if (text == null) return;
  Fluttertoast.showToast(
      msg: "$text",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black38,
      textColor: Colors.white,
      fontSize: 14.0);
}
