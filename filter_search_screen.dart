import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/app_constants.dart';
import 'package:foodtek/l10n/app_localizations.dart';
import 'package:foodtek/view/widgets/input_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../app_style.dart';
import '../../controller/filter_controller.dart';
import '../../controller/lang_controller.dart';

class FilterSearchScreen extends StatelessWidget {
  const FilterSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color secondaryTextColor =
        isDarkMode ? Colors.grey[300]! : Colors.grey[600]!;
    final Color buttonBackgroundColor =
        isDarkMode ? Colors.green : Color(0xFFF2F4F7);
    final Color sliderInactiveColor =
        isDarkMode ? Colors.grey[700]! : Color(0xFFF3F4F6);
    final Color sliderActiveColor = AppConstants.buttonColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: backgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                  AppLocalizations.of(context)!.filter, context, textColor),
              _buildSectionTitle(AppLocalizations.of(context)!.price_range,
                  context, secondaryTextColor),
              SizedBox(height: 24.h),
              _buildPriceInputs(context),
              _buildSlider(context, AppLocalizations.of(context)!.price,
                  sliderInactiveColor, sliderActiveColor),
              _buildSectionTitle(AppLocalizations.of(context)!.discount,
                  context, secondaryTextColor),
              SizedBox(height: 24.h),
              _buildDiscountInputs(context),
              _buildSlider(context, AppLocalizations.of(context)!.discount,
                  sliderInactiveColor, sliderActiveColor),
              SizedBox(height: 24.h),
              _buildSectionTitle(AppLocalizations.of(context)!.category,
                  context, secondaryTextColor),
              SizedBox(height: 14.h),
              _buildButtonRow(["Fast Food", "Sea Food", "Desert"], "category",
                  buttonBackgroundColor),
              _buildSectionTitle(AppLocalizations.of(context)!.location,
                  context, secondaryTextColor),
              SizedBox(height: 14.h),
              _buildButtonRow(
                  ["1 KM", "5 KM", "10 KM"], "location", buttonBackgroundColor),
              _buildSectionTitle(AppLocalizations.of(context)!.dish, context,
                  secondaryTextColor),
              SizedBox(height: 14.h),
              _buildButtonWrap([
                "Tuna Tartare",
                "Spicy Crab Cakes",
                "Seafood Paella",
                "Clam Chowder",
                "Miso-Glazed Cod",
                "Lobster Thermidor"
              ], "dish", buttonBackgroundColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title, BuildContext context, Color textColor) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    return Text(
      title,
      style: AppStyles.getFontStyle(
        langController,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }

  Widget _buildSectionTitle(
      String title, BuildContext context, Color textColor) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Text(
        title,
        style: AppStyles.getFontStyle(
          langController,
          fontSize: 14.sp,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPriceInputs(BuildContext context) {
    return Consumer<FilterController>(
      builder: (context, filterController, child) {
        return Row(
          children: [
            InputWidget(
              textEditingController: filterController.minPriceController,
              obscureText: false,
              borderRadius: BorderRadius.circular(5.r),
              width: 180.w,
              keyboardType: TextInputType.number,
              borderColor: Color(0xFFEAFAEB),
              backgroundColor: Colors.white,
              label: AppLocalizations.of(context)!.min,
            ),
            SizedBox(width: 16.w),
            InputWidget(
              textEditingController: filterController.maxPriceController,
              obscureText: false,
              borderRadius: BorderRadius.circular(5.r),
              width: 180.w,
              keyboardType: TextInputType.number,
              borderColor: Color(0xFFEAFAEB),
              backgroundColor: Colors.white,
              label: AppLocalizations.of(context)!.max,
            ),
          ],
        );
      },
    );
  }

  Widget _buildDiscountInputs(BuildContext context) {
    return Consumer<FilterController>(
      builder: (context, filterController, child) {
        return Row(
          children: [
            InputWidget(
              textEditingController: filterController.minDiscountController,
              obscureText: false,
              borderRadius: BorderRadius.circular(5.r),
              width: 180.w,
              keyboardType: TextInputType.number,
              borderColor: Color(0xFFEAFAEB),
              backgroundColor: Colors.white,
              label: AppLocalizations.of(context)!.min,
            ),
            SizedBox(width: 16.w),
            InputWidget(
              textEditingController: filterController.maxDiscountController,
              obscureText: false,
              borderRadius: BorderRadius.circular(5.r),
              width: 180.w,
              keyboardType: TextInputType.number,
              borderColor: Color(0xFFEAFAEB),
              backgroundColor: Colors.white,
              label: AppLocalizations.of(context)!.max,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSlider(BuildContext context, String type,
      Color sliderInactiveColor, Color sliderActiveColor) {
    return Consumer<FilterController>(
      builder: (context, filterController, child) {
        final minValue = type == AppLocalizations.of(context)!.price
            ? int.tryParse(filterController.minPriceController.text) ?? 0
            : int.tryParse(filterController.minDiscountController.text) ?? 0;
        final maxValue = type == AppLocalizations.of(context)!.price
            ? int.tryParse(filterController.maxPriceController.text) ?? 10
            : int.tryParse(filterController.maxDiscountController.text) ?? 50;

        if (minValue > maxValue) {
          if (type == AppLocalizations.of(context)!.price) {
            filterController.minPriceController.text = "0";
          } else {
            filterController.minDiscountController.text = "0";
          }
        }

        return SfSlider(
          min: minValue.toDouble(),
          max: maxValue.toDouble(),
          value: type == AppLocalizations.of(context)!.price
              ? filterController.sliderPriceValue
              : filterController.sliderDiscountValue,
          showLabels: true,
          inactiveColor: sliderInactiveColor,
          activeColor: sliderActiveColor,
          onChanged: (dynamic newValue) {
            if (type == AppLocalizations.of(context)!.price) {
              filterController.updateSlider(
                AppLocalizations.of(context)!.price,
                newValue,
              );
            } else {
              filterController.updateSlider(
                AppLocalizations.of(context)!.discount,
                newValue,
              );
            }
          },
        );
      },
    );
  }

  Widget _buildButtonRow(
      List<String> labels, String type, Color buttonBackgroundColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: labels.map((label) {
          final index = labels.indexOf(label);
          return _buildButton(label, index, type, buttonBackgroundColor);
        }).toList(),
      ),
    );
  }

  Widget _buildButtonWrap(
      List<String> labels, String type, Color buttonBackgroundColor) {
    return Wrap(
      spacing: 16.w,
      runSpacing: 8.h,
      children: labels.map((label) {
        final index = labels.indexOf(label);
        return _buildButton(label, index, type, buttonBackgroundColor);
      }).toList(),
    );
  }

  Widget _buildButton(
      String label, int index, String type, Color buttonBackgroundColor) {
    return Consumer<FilterController>(
      builder: (context, controller, child) {
        final isSelected = type == AppLocalizations.of(context)!.category
            ? controller.selectedCategoryIndex == index
            : type == AppLocalizations.of(context)!.location
                ? controller.selectedLocationIndex == index
                : controller.selectedDishIndex == index;

        return Container(
          margin: EdgeInsets.only(right: 16.0),
          child: TextButton(
            onPressed: () {
              controller.updateSelected(type, label, index);
            },
            style: TextButton.styleFrom(
              backgroundColor:
                  isSelected ? Colors.green : buttonBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
