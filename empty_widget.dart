import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../app_style.dart';

import '../../../controller/lang_controller.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  EmptyWidget({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/empty.png",
            height: 285.h,
            width: 285.w,
          ),
          SizedBox(height: 50.h),
          Center(
            child: Text(
              title,
              style: AppStyles.getFontStyle(
                langController,
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: isDark
                    ? theme.colorScheme.onSurface
                    : Color(0xFF111827), // Dynamic color based on theme
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            textAlign: TextAlign.center,
            subTitle,
            style: AppStyles.getFontStyle(
              langController,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white70 : Colors.grey, // Dynamic color
            ),
          ),
        ],
      ),
    );
  }
}
