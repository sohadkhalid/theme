import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/app_constants.dart';
import 'package:foodtek/controller/login_controller.dart';
import 'package:foodtek/l10n/app_localizations.dart';
import 'package:foodtek/view/screens/registration_screens/login_screen.dart';
import 'package:foodtek/view/screens/registration_screens/success_reset_password_screen.dart';
import 'package:foodtek/view/widgets/onboarding_widgets/back_arrow_widget.dart';
import 'package:foodtek/view/widgets/registration_widgets/login_button_widget.dart';
import 'package:foodtek/view/widgets/registration_widgets/password_field_widget.dart';
import 'package:provider/provider.dart';

import '../../../app_style.dart';
import '../../../controller/lang_controller.dart';
import '../../widgets/onboarding_widgets/app_title_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    LoginController loginController =
        Provider.of<LoginController>(context, listen: false);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  colorFilter: isDark
                      ? ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.darken)
                      : null,
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
            child: Container(
              width: 343.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: isDark ? Colors.grey[900] : Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.sp),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackArrowWidget(
                        onPressed: () {
                          Navigator.pop(context);
                          loginController.clearErrors();
                          _clearFields(loginController);
                        },
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        AppLocalizations.of(context)!.reset_password_title,
                        textAlign: TextAlign.center,
                        style: AppStyles.getFontStyle(
                          langController,
                          color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,

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
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .color
                                ?.withOpacity(0.6) ?? Colors.black.withOpacity(0.6),

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
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Consumer<LoginController>(
                        builder: (context, loginController, child) {
                          return PasswordFieldWidget(
                            loginController: loginController,
                            title: AppLocalizations.of(context)!.new_password,
                            controller: loginController.passwordController,
                            hintText:
                                AppLocalizations.of(context)!.new_password_hint,
                            obscureText: loginController.obscureText,
                            onChange: (value) => loginController.validateField(
                              field: 'password',
                              value: value,
                              context: context,
                            ),
                            errorText: loginController.errors['password'],
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  loginController.togglePasswordVisibility(),
                              icon: Icon(
                                loginController.obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20.sp,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      Consumer<LoginController>(
                        builder: (context, loginController, child) {
                          return PasswordFieldWidget(
                            loginController: loginController,
                            title:
                                AppLocalizations.of(context)!.confirm_password,
                            controller:
                                loginController.confirmPasswordController,
                            hintText: AppLocalizations.of(context)!
                                .confirm_password_hint,
                            obscureText: loginController.obscureText2,
                            onChange: (value) => loginController.validateField(
                              field: 'confirmPassword',
                              value: value,
                              context: context,
                            ),
                            errorText:
                                loginController.errors['confirmPassword'],
                            suffixIcon: IconButton(
                              onPressed: () => loginController
                                  .toggleConfirmPasswordVisibility(),
                              icon: Icon(
                                loginController.obscureText2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20.sp,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24.h),
                      LoginButtonWidget(
                        textColor: Colors.white,
                        buttonName: AppLocalizations.of(context)!
                            .update_password_button,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          loginController.setLoading(true);
                          loginController.clearErrors();

                          loginController.validatePassword(
                              loginController.passwordController.text);
                          loginController.validateConfirmPassword(
                            loginController.confirmPasswordController.text,
                            loginController.passwordController.text,
                            context,
                          );

                          if (!loginController.isFormValid()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: isDark
                                    ? Colors.grey[800]
                                    : Color(0xFFE7F4FF),
                                content: Text(
                                  AppLocalizations.of(context)!.error_message,
                                  style: AppStyles.getFontStyle(
                                    langController,
                                    color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,

                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            if (loginController.passwordController.text
                                    .trim() ==
                                loginController.confirmPasswordController.text
                                    .trim()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SuccessResetPasswordScreen(),
                                ),
                              );
                              _clearFields(loginController);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.amber,
                                  content: Text(
                                    AppLocalizations.of(context)!
                                        .passwords_error,
                                    style: AppStyles.getFontStyle(
                                      langController,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                          loginController.setLoading(false);
                        },
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearFields(LoginController loginController) {
    loginController.passwordController.clear();
    loginController.confirmPasswordController.clear();
  }
}
