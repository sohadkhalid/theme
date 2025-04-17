import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/app_constants.dart';
import 'package:foodtek/controller/location_controller.dart';
import 'package:foodtek/l10n/app_localizations.dart';
import 'package:foodtek/view/screens/registration_screens/login_screen.dart';
import 'package:foodtek/view/widgets/onboarding_widgets/slides_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button_widget.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Provider.of<LocationController>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SlideWidget(
        backgroundImage: const AssetImage("assets/images/maps.png"),
        imagePath: "assets/images/slide2.png",
        title: AppLocalizations.of(context)!.onboarding_title4,
        description: AppLocalizations.of(context)!.onboarding_subtitle4,
        widget: Column(
          children: [
            CustomButtonWidget(
              title: AppLocalizations.of(context)!.yes_turn_it_on,
              onPressed: () async {
                await locationController.requestLocationPermission(context);
              },
            ),
            SizedBox(height: 8.h),
            CustomButtonWidget(
              title: AppLocalizations.of(context)!.cancel,
              titleColor: isDark ? Colors.white : AppConstants.primaryTextColor(context),

              colors: [
                isDark ? Colors.grey[700]! : const Color(0xFFC2C2C2),
                isDark ? Colors.grey[700]! : const Color(0xFFC2C2C2),
              ],
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
