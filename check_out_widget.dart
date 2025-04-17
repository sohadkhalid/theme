import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../app_constants.dart';
import '../../../app_style.dart';

import '../../../controller/cart_controller.dart';
import '../../../controller/lang_controller.dart';
import '../custom_button_widget.dart';

class CheckOutWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  CheckOutWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cartController, _) {
        final subTotal = cartController.calculateSubTotal();
        const deliveryCharge = 10.0;
        const discount = 10.0;
        final total = subTotal + deliveryCharge - discount;

        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Container(
          width: 387.w,
          decoration: BoxDecoration(
            color:
                isDark ? theme.colorScheme.surface : AppConstants.buttonColor,
            borderRadius: BorderRadius.circular(7.r),
            image: DecorationImage(
              image: AssetImage("assets/images/back.png"),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                isDark ? Colors.black.withOpacity(0.3) : Colors.transparent,
                BlendMode.darken,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              children: [
                _buildRow(
                  AppLocalizations.of(context)!.subtotal,
                  "\$$subTotal",
                  14.sp,
                  FontWeight.w500,
                  context,
                ),
                SizedBox(height: 6.h),
                _buildRow(
                  AppLocalizations.of(context)!.delivery_charge,
                  "\$$deliveryCharge",
                  14.sp,
                  FontWeight.w500,
                  context,
                ),
                SizedBox(height: 6.h),
                _buildRow(
                  AppLocalizations.of(context)!.discount,
                  "-\$$discount",
                  14.sp,
                  FontWeight.w500,
                  context,
                ),
                SizedBox(height: 6.h),
                _buildRow(
                  AppLocalizations.of(context)!.total,
                  "\$$total",
                  18.sp,
                  FontWeight.w700,
                  context,
                ),
                SizedBox(height: 28.h),
                CustomButtonWidget(
                  title: AppLocalizations.of(context)!.place_my_order,
                  borderRadius: 7.r,
                  width: double.infinity,
                  height: 60.h,
                  titleColor: isDark ? Colors.black : AppConstants.buttonColor,
                  colors: [
                    theme.colorScheme.onPrimary,
                    theme.colorScheme.onPrimary
                  ],
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow(
    String label,
    String value,
    double fontSize,
    FontWeight fontWeight,
    BuildContext context,
  ) {
    LangController langController = Provider.of<LangController>(
      context,
      listen: false,
    );

    final textColor = Theme.of(context).colorScheme.onPrimary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.getFontStyle(
            langController,
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontWeight,
          ),
        ),
        Text(
          value,
          style: AppStyles.getFontStyle(
            langController,
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
