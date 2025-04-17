import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:foodtek/controller/home_page_controller.dart';
import 'package:provider/provider.dart';
import '../../app_style.dart';
import '../../controller/lang_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/home_widgets/category_grid_view_widget.dart';
import '../widgets/home_widgets/food_item_widget.dart';
import '../widgets/home_widgets/search_bar_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LangController langController = Provider.of<LangController>(
      context,
      listen: false,
    );

    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color greyColor = isDarkMode ? Colors.grey[300]! : Colors.grey[600]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                AppLocalizations.of(context)!.favorites,
                style: AppStyles.getFontStyle(
                  langController,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: textColor,
                ),
              ),
            ),
            Consumer<HomePageController>(
              builder: (context, homePageController, child) {
                if (homePageController.fav.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.no_favorites,
                      style: AppStyles.getFontStyle(
                        langController,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: greyColor,
                      ),
                    ),
                  );
                }
                final List<FoodItemWidget> favoriteWidgets =
                    homePageController.fav.map((foodItem) {
                  return FoodItemWidget(foodItem: foodItem);
                }).toList();

                return CategoryGridViewWidget(items: favoriteWidgets);
              },
            ),
          ],
        ),
      ),
    );
  }
}
