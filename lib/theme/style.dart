import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Style {
  static const isDark = false;

  static const defaultColor = Colors.deepOrange;

  //font families
  static const ard = 'ARD';
  static const colona = 'COLONA';
  static const corbel = 'CORBEL';

  //this is for show toast
  static void toast({required String message, required BuildContext context}) {
    showToast(
      message,
      textStyle: const TextStyle(
        fontFamily: Style.corbel,
        fontWeight: FontWeight.bold,
      ),
      context: context,
      backgroundColor: Colors.grey,
    );
  }
}
