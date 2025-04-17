import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../../app_style.dart';
import '../../../controller/lang_controller.dart';

class SlideWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Widget widget;
  final AssetImage? backgroundImage;

  const SlideWidget(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description,
      required this.widget,
      this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);

    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        image: DecorationImage(
          image: backgroundImage ?? AssetImage("assets/images/pattern.png"),
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 681.h,
              width: double.infinity,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(imagePath),
                    height: 328.h,
                    width: 328.w,
                    filterQuality: FilterQuality.high,
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppStyles.getFontStyle(
                      langController,
                      color: theme.textTheme.titleLarge?.color ?? AppConstants.primaryTextColor as Color,

                      fontWeight: FontWeight.w500,
                      fontSize: 32.sp,
                    ),

                  ),
                  SizedBox(height: 8.h),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: AppStyles.getFontStyle(
                      langController,
                      color: theme.textTheme.titleLarge?.color ?? AppConstants.primaryTextColor as Color,

                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 110.h),
                  widget
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
