import 'package:flutter/material.dart';
import 'package:foodtek/view/widgets/main_widgets/notification_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../app_style.dart';
import '../../../controller/home_page_controller.dart';
import '../../../controller/lang_controller.dart';
import '../../../l10n/app_localizations.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final TabBar? tabBar;

  const MainAppBarWidget({super.key, this.tabBar});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDark
          ? Colors.black
          : Colors.white, // Background color changes based on theme
      title: ListTile(
        leading: _buildLocationButton(isDark),
        title: _buildLocationTitle(context, isDark),
        subtitle: _buildLocationSubtitle(context, isDark),
      ),
      bottom: tabBar,
      actions: [NotificationButton()],
    );
  }

  Widget _buildLocationButton(bool isDark) {
    return Consumer<HomePageController>(
        builder: (context, homePageController, child) {
      if (homePageController.isProductDetailsSelected) {
        return IconButton(
          onPressed: () {
            homePageController.toggleProductDetails();
          },
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
        );
      } else {
        return Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: isDark
                ? Color(0xFF3A3A3A)
                : Color(0xFFEDF7EF), // Background color for button
            borderRadius: BorderRadius.circular(4),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Image.asset(
              "assets/images/location.png",
              height: 22,
              width: 22,
              color: isDark ? Colors.white : null, // Icon color based on theme
            ),
          ),
        );
      }
    });
  }

  Widget _buildLocationTitle(BuildContext context, bool isDark) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    return GestureDetector(
      onTap: () {},
      child: Text(
        AppLocalizations.of(context)!.current_location,
        style: AppStyles.getFontStyle(
          langController,
          fontSize: 12,
          color:
              isDark ? Colors.white : Color(0xFF606060), // Color based on theme
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLocationSubtitle(BuildContext context, bool isDark) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    return Text(
      'Jl. Soekarno Hatta 15A...',
      style: AppStyles.getFontStyle(
        langController,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color:
            isDark ? Colors.white : Color(0xFF101010), // Color based on theme
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Size get preferredSize {
    return tabBar == null
        ? Size.fromHeight(kToolbarHeight)
        : Size.fromHeight(kToolbarHeight * 2);
  }
}
