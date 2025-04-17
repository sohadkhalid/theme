import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/app_constants.dart';
import 'package:foodtek/controller/login_controller.dart';
import 'package:foodtek/l10n/app_localizations.dart';
import 'package:foodtek/view/screens/registration_screens/login_screen.dart';
import 'package:foodtek/view/widgets/onboarding_widgets/back_arrow_widget.dart';
import 'package:foodtek/view/widgets/registration_widgets/login_button_widget.dart';
import 'package:foodtek/view/widgets/registration_widgets/password_field_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../app_style.dart';
import '../../../controller/lang_controller.dart';
import '../../../theme/theme_provider.dart';
import '../../widgets/onboarding_widgets/app_title_widget.dart';

class SuccessResetPasswordScreen extends StatefulWidget {
  const SuccessResetPasswordScreen({super.key});

  @override
  State<SuccessResetPasswordScreen> createState() =>
      _SuccessResetPasswordScreenState();
}

class _SuccessResetPasswordScreenState
    extends State<SuccessResetPasswordScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    LoginController loginController = Provider.of<LoginController>(
      context,
      listen: false,
    );

    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : AppConstants.buttonColor,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pattern.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.h),
                    AppTitleWidget(),
                    SizedBox(height: 25.h),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 437.h,
              width: 343.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: isDarkMode ? Colors.grey[800] : Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 24.sp),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackArrowWidget(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        AppLocalizations.of(context)!.reset_password_title,
                        textAlign: TextAlign.center,
                        style: AppStyles.getFontStyle(
                          langController,
                          color: isDarkMode ? Colors.white : Color(0xFF111827),
                          fontWeight: FontWeight.w700,
                          fontSize: 32.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text.rich(
                        TextSpan(
                          text: AppLocalizations.of(context)!.current_password,
                          style: AppStyles.getFontStyle(
                            langController,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6C7278),
                          ),
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.login_title,
                              style: AppStyles.getFontStyle(
                                langController,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: AppConstants.buttonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      PasswordFieldWidget(
                        loginController: loginController,
                        title: AppLocalizations.of(context)!.new_password,
                        controller: loginController.passwordController,
                        hintText:
                            AppLocalizations.of(context)!.new_password_hint,
                        obscureText: false,
                      ),
                      SizedBox(height: 16.h),
                      PasswordFieldWidget(
                        loginController: loginController,
                        title: AppLocalizations.of(context)!.confirm_password,
                        controller: loginController.confirmPasswordController,
                        hintText:
                            AppLocalizations.of(context)!.confirm_password_hint,
                        obscureText: false,
                      ),
                      SizedBox(height: 24.h),
                      LoginButtonWidget(
                        textColor: Colors.white,
                        buttonName:
                            AppLocalizations.of(context)!.register_button,
                        onPressed: () {},
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/s.png",
                  height: 287.h,
                  width: 430.5.w,
                ),
                Text(
                  AppLocalizations.of(context)!.congratulations,
                  style: AppStyles.getFontStyle(
                    langController,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 32.sp,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.password_reset_success,
                  style: AppStyles.getFontStyle(
                    langController,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
