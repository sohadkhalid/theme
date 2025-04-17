import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../app_constants.dart';
import '../../app_style.dart';
import '../../controller/lang_controller.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? label;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? errorText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Color backgroundColor;
  final Color borderColor;
  final double? width;
  final double? fontSize;
  final BorderRadius? borderRadius;
  final double? height;
  final Color? hintColor;
  final bool? readOnly;
  final BorderSide? borderSide;

  const InputWidget({
    super.key,
    required this.textEditingController,
    this.label,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.keyboardType,
    this.backgroundColor = const Color(0xFFECF0F6),
    this.borderColor = Colors.transparent,
    this.width,
    this.height,
    this.fontSize,
    this.borderRadius,
    this.hintColor,
    this.readOnly = false,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    LangController langController = Provider.of<LangController>(
      context,
      listen: false,
    );

    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height ?? 60.h,
            width: width ?? 295.w,
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(10.r),
              color: backgroundColor,
              border: Border.all(color: borderColor, width: 1.w),
            ),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              obscureText: obscureText,
              controller: textEditingController,
              maxLines: 1,
              onChanged: onChanged,
              keyboardType: keyboardType,
              readOnly: readOnly!,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: borderSide ??
                      BorderSide(
                        color: theme.primaryColor,
                        width: 2.w,
                      ),
                ),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                labelText: label,
                labelStyle: AppStyles.getFontStyle(
                  langController,
                  color: theme.textTheme.bodyLarge?.color ?? Colors.black,
                ),//color: theme.textTheme.bodyLarge?.color ?? AppConstants.primaryTextColor,

                hintText: hintText,
                hintStyle: AppStyles.getFontStyle(
                  langController,
                  fontSize: fontSize ?? 14.sp,
                  color: hintColor ?? theme.hintColor,
                ),
                errorText: null,
                contentPadding: EdgeInsets.only(
                  left: 14.0.sp,
                  top: 12.5.sp,
                  bottom: 12.5.sp,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          if (errorText != null && errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                errorText!,
                style: TextStyle(color: Colors.red, fontSize: 12.sp),
              ),
            ),
        ],
      ),
    );
  }
}
