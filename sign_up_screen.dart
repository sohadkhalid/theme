import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/l10n/app_localizations.dart';
import 'package:foodtek/view/screens/home_screen.dart';
import 'package:foodtek/view/screens/registration_screens/login_screen.dart';
import 'package:foodtek/view/widgets/registration_widgets/password_field_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../../app_constants.dart';

import '../../../app_style.dart';
import '../../../controller/lang_controller.dart';
import '../../../controller/login_controller.dart';
import '../../../theme/theme_provider.dart';
import '../../widgets/onboarding_widgets/app_title_widget.dart';
import '../../widgets/onboarding_widgets/back_arrow_widget.dart';
import '../../widgets/registration_widgets/email_field_widget.dart';
import '../../widgets/input_widget.dart';
import '../../widgets/registration_widgets/login_button_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor:
              themeProvider.isDarkMode ? Colors.black : const Color(0xFF25AE4B),
          body: Center(
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
                    Container(
                      width: 343.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: themeProvider.isDarkMode
                            ? Colors.grey[800]
                            : Colors.white,
                      ),
                      child: Selector<LoginController, bool>(
                        selector: (context, loginController) =>
                            loginController.isLoginMode,
                        builder: (context, isLoginMode, _) {
                          return SingleChildScrollView(
                            child: _buildLoginForm(
                                context, isLoginMode, themeProvider),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 25.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginForm(
      BuildContext context, bool isLoginMode, ThemeProvider themeProvider) {
    final loginController = context.watch<LoginController>();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0.sp, top: 8.sp),
          child: BackArrowWidget(
            onPressed: () {
              loginController.clearErrors();
              _clearFields(loginController);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ),
        _buildTitle(context, themeProvider),
        SizedBox(height: 12.h),
        _buildSwitchModeRow(context, loginController, themeProvider),
        SizedBox(height: 24.h),
        _buildNameInput(context, loginController),
        SizedBox(height: 16.h),
        EmailFieldWidget(loginController: loginController),
        SizedBox(height: 16.h),
        _buildDateOfBirthInput(context, loginController),
        SizedBox(height: 16.h),
        _buildPhoneNumberInput(context, loginController),
        PasswordFieldWidget(
          loginController: loginController,
          title: AppLocalizations.of(context)!.self_password,
          hintText: AppLocalizations.of(context)!.password_hint,
          controller: loginController.passwordController,
          onChange: (value) => loginController.validateField(
            field: 'password',
            value: value,
            context: context,
          ),
          errorText: loginController.errors['password'],
          obscureText: loginController.obscureText,
          suffixIcon: IconButton(
            onPressed: () {
              loginController.togglePasswordVisibility();
            },
            icon: Icon(
              loginController.obscureText
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: themeProvider.isDarkMode ? Colors.white : Colors.grey,
              size: 20.sp,
            ),
          ),
        ),
        _buildSubmitButton(context, loginController, themeProvider),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, ThemeProvider themeProvider) {
    LangController langController = Provider.of<LangController>(
      context,
      listen: false,
    );
    return Padding(
      padding: EdgeInsets.only(top: 24.sp, left: 24.sp, right: 24.sp),
      child: Text(
        AppLocalizations.of(context)!.signup_title,
        style: AppStyles.getFontStyle(
          langController,
          color:
              themeProvider.isDarkMode ? Colors.white : const Color(0xFF111827),
          fontWeight: FontWeight.w700,
          fontSize: 32.sp,
        ),
      ),
    );
  }

  Widget _buildSwitchModeRow(
    BuildContext context,
    LoginController loginController,
    ThemeProvider themeProvider,
  ) {
    LangController langController = Provider.of<LangController>(
      context,
      listen: false,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.sp, right: 24.sp),
          child: Text(
            AppLocalizations.of(context)!.signup_subtitle,
            style: AppStyles.getFontStyle(
              langController,
              color:
                  themeProvider.isDarkMode ? Colors.white70 : Color(0xFF6C7278),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            loginController.clearErrors();
            _clearFields(loginController);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text(
            AppLocalizations.of(context)!.login_title,
            style: AppStyles.getFontStyle(
              langController,
              color: AppConstants.buttonColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildNameInput(
      BuildContext context,
      LoginController loginController,
      ) {
    return Selector<LoginController, String?>(
      selector: (context, loginController) => loginController.errors['name'],
      builder: (context, errorText, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.full_name,
              style: GoogleFonts.plusJakartaSans(
                color: Color(0xFF6C7278),
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            InputWidget(
              backgroundColor: Colors.white,
              borderColor: Color(0xFFEFF0F6),
              textEditingController: loginController.nameController,
              obscureText: false,
              keyboardType: TextInputType.name,
              hintText: AppLocalizations.of(context)!.full_name_hint,
              onChanged:
                  (value) => loginController.validateField(
                field: 'name',
                value: value,
                context: context,
              ),
              errorText: errorText,
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateOfBirthInput(
      BuildContext context,
      LoginController loginController,
      ) {
    LangController langController = Provider.of<LangController>(
      context,
      listen: false,
    );
    return Selector<LoginController, String?>(
      selector: (context, loginController) => loginController.errors['birth'],
      builder: (context, errorText, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.date_of_birth,
              style: GoogleFonts.plusJakartaSans(
                color: Color(0xFF6C7278),
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            InputWidget(
              backgroundColor: Colors.white,
              borderColor: Color(0xFFEFF0F6),
              textEditingController: loginController.birthController,
              obscureText: false,
              keyboardType: TextInputType.none,
              hintText: "DD/MM/YYYY",
              readOnly: true,
              onChanged:
                  (value) => loginController.validateField(
                field: 'birth',
                value: value,
                context: context,
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  DateTime? selectedDate = await showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      DateTime tempSelectedDate = DateTime.now();
                      return Container(
                        height: 330.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 15.h),
                            Container(
                              height: 200.h,
                              child: CupertinoDatePicker(
                                initialDateTime:
                                loginController.getValidInitialDate(),
                                onDateTimeChanged: (DateTime newDate) {
                                  tempSelectedDate = newDate;
                                },
                                mode: CupertinoDatePickerMode.date,
                                maximumYear: DateTime.now().year - 16,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 150.w,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      backgroundColor: Color(0xFFC2C2C2),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop(null);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.cancel,
                                      style: AppStyles.getFontStyle(
                                        langController,
                                        color: AppConstants.primaryTextColor(context),

                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 150.w,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      backgroundColor: AppConstants.buttonColor,
                                    ),
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                      ).pop(tempSelectedDate);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.select_date,
                                      style: AppStyles.getFontStyle(
                                        langController,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  if (selectedDate != null) {
                    String formattedDate =
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                    loginController.birthController.text = formattedDate;
                    loginController.validateField(
                      field: 'birth',
                      value: formattedDate,
                      context: context,
                    );
                  }
                },
                icon: Image.asset(
                  "assets/images/calendar-due.png",
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ),
            if (errorText != null)
              Padding(
                padding: EdgeInsets.only(top: 8.sp),
                child: Text(
                  errorText,
                  style: TextStyle(color: Colors.red, fontSize: 12.sp),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildPhoneNumberInput(
      BuildContext context,
      LoginController loginController,
      ) {
    return Padding(
      padding: EdgeInsets.only(left: 24.sp, right: 24.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.phone_number,
            style: GoogleFonts.plusJakartaSans(
              color: Color(0xFF6C7278),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 80.h,
            child: IntlPhoneField(
              controller: loginController.phoneNumberController,
              dropdownIconPosition: IconPosition.leading,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.phone_number,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xFFBBBFC5),
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: BorderSide(color: Color(0xFFEFF0F6), width: 1.w),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: BorderSide(color: Color(0xFFEFF0F6), width: 1.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: BorderSide(
                    color: AppConstants.buttonColor,
                    width: 2.w,
                  ),
                ),
              ),
              initialCountryCode: loginController.selectedCountryCode,
              onChanged: (phone) {
                if (phone.number.isEmpty) {
                  loginController.errors['phone'] =
                      AppLocalizations.of(context)!.phone_error;
                } else {
                  loginController.errors['phone'] = null;
                }
                loginController.phoneNumber = phone.completeNumber;
                loginController.validateField(
                  field: 'phone',
                  value: phone.completeNumber,
                  context: context,
                );
              },
            ),
          ),
          if (loginController.errors['phone'] != null &&
              loginController.errors['phone']!.isNotEmpty)
            Text(
              loginController.errors['phone']!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
        ],
      ),
    );
  }

  // ... (other widget methods like _buildNameInput, _buildDateOfBirthInput, etc.)

  Widget _buildSubmitButton(
    BuildContext context,
    LoginController loginController,
    ThemeProvider themeProvider,
  ) {
    LangController langController = Provider.of<LangController>(
      context,
      listen: false,
    );
    return Padding(
      padding: EdgeInsets.only(top: 24.sp, bottom: 24.sp),
      child: Selector<LoginController, bool>(
        selector: (context, loginController) => loginController.isLoading,
        builder: (context, isLoading, _) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF170F4C)),
                )
              : LoginButtonWidget(
                  textColor: Colors.white,
                  buttonName: AppLocalizations.of(context)!.register_button,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    loginController.setLoading(true);

                    loginController.validateForm(
                      email: loginController.emailController.text,
                      password: loginController.passwordController.text,
                      name: loginController.nameController.text,
                      phone: loginController.phoneNumberController.text,
                      birth: loginController.birthController.text,
                      context: context,
                    );

                    if (!loginController.isFormValid()) {
                      print(loginController.errors);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            AppLocalizations.of(context)!.error_message,
                            style: AppStyles.getFontStyle(
                              langController,
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF170F4C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    }
                    loginController.setLoading(false);
                  },
                );
        },
      ),
    );
  }

  void _clearFields(LoginController loginController) {
    loginController.emailController.clear();
    loginController.passwordController.clear();
    loginController.nameController.clear();
    loginController.birthController.clear();
    loginController.phoneNumberController.clear();
    loginController.clearErrors();
  }
}
