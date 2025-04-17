import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../controller/login_controller.dart';
import '../input_widget.dart';

class PasswordFieldWidget extends StatelessWidget {
  final LoginController loginController;
  final String title;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final Function(String)? onChange;

  PasswordFieldWidget({
    super.key,
    required this.loginController,
    required this.title,
    required this.controller,
    this.suffixIcon,
    this.hintText,
    this.onChange,
    this.errorText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            color: theme.textTheme.bodyLarge?.color ?? Color(0xFF6C7278),
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        InputWidget(
          backgroundColor: theme.scaffoldBackgroundColor,
          borderColor: theme.dividerColor,
          textEditingController: controller,
          obscureText: obscureText,
          suffixIcon: suffixIcon,
          hintText: hintText,
          onChanged: onChange,
          errorText: errorText,
        ),
      ],
    );
  }
}
