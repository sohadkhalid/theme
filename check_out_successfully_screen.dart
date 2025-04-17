import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/app_constants.dart';
import 'package:foodtek/view/screens/main_screen.dart';
import 'package:foodtek/view/widgets/custom_button_widget.dart';
import 'package:foodtek/view/widgets/main_widgets/notification_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../../app_style.dart';
import '../../../controller/lang_controller.dart';
import '../../../l10n/app_localizations.dart';

class CheckOutSuccessfullyScreen extends StatelessWidget {
  const CheckOutSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [NotificationButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.checkout,
              style: AppStyles.getFontStyle(
                langController,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
            SizedBox(height: 100.h),
            Center(
              child: Image.asset("assets/images/group2.png", height: 290.h),
            ),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context)!.order_done_successfully,
                style: AppStyles.getFontStyle(
                  langController,
                  fontSize: 24.sp,
                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context)!
                    .you_will_get_your_order_within_12min,
                style: AppStyles.getFontStyle(
                  langController,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.grey[300]! : const Color(0xFF263238),
                ),
              ),
            ),
            SizedBox(height: 45.h),
            Center(
              child: CustomButtonWidget(
                title: AppLocalizations.of(context)!.track_your_order,
                colors: [AppConstants.buttonColor, AppConstants.buttonColor],
                titleColor: Colors.white,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                    (route) => false,
                  );
                },
                borderRadius: 16.r,
                height: 60.h,
                width: 330.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
