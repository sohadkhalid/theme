import 'package:flutter/material.dart';

class AppConstants {
  static const Color buttonColor = Color(0xFF25AE4B); // constant not change

  static Color primaryTextColor(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
  }

  static Color backgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color borderColor(BuildContext context) {
    return Theme.of(context).dividerColor;
  }

  static Color hintTextColor(BuildContext context) {
    return Theme.of(context).hintColor;
  }

  static Color iconColor(BuildContext context) {
    return Theme.of(context).iconTheme.color ?? Colors.grey;
  }
}
