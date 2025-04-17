import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/l10n/app_localizations.dart';
import 'package:foodtek/view/screens/registration_screens/reset_password_screen.dart';
import 'package:foodtek/view/widgets/registration_widgets/login_button_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../app_constants.dart';
import '../../../app_style.dart';

import '../../../controller/lang_controller.dart';
import '../../widgets/onboarding_widgets/app_title_widget.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LangController langController = Provider.of<LangController>(
      context,
      listen: false,
    );

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: AppStyles.getFontStyle(
        langController,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white : Colors.black,
      ),
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? Colors.grey.shade700 : Color(0xFFEDF1F3),
          width: 1.w,
        ),
      ),
    );

    final pinController = TextEditingController();

    return Scaffold(
      backgroundColor: AppConstants.buttonColor,
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
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withOpacity(0.5)
                      : Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 343.w,
              height: 399.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: isDark ? Color(0xFF1A1A1A) : Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 24.h),
                    Image.asset(
                      "assets/images/otp.png",
                      height: 153.h,
                      width: 153.w,
                    ),
                    SizedBox(height: 14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.sp),
                      child: Text(
                        AppLocalizations.of(context)!
                            .verification_code_instruction,
                        textAlign: TextAlign.center,
                        style: AppStyles.getFontStyle(
                          langController,
                          color: isDark ? Colors.white70 : Color(0xFF6C7278),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Pinput(
                      keyboardType: TextInputType.number,
                      controller: pinController,
                      defaultPinTheme: defaultPinTheme,
                      length: 4,
                      onCompleted: (pin) {
                        print("Entered PIN: $pin");
                      },
                    ),
                    SizedBox(height: 24.h),
                    LoginButtonWidget(
                      buttonName: AppLocalizations.of(context)!.verify_button,
                      onPressed: () {
                        final otp = pinController.text;
                        if (otp.isNotEmpty && otp.length == 4) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPasswordScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  isDark ? Colors.grey[900] : Colors.white,
                              content: Text(
                                AppLocalizations.of(context)!.otp_error,
                                style: TextStyle(
                                    color:
                                        isDark ? Colors.white : Colors.black),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
