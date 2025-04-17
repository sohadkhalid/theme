import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodtek/app_constants.dart';

class MainBottomNavigationBar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTabTapped;

  const MainBottomNavigationBar({
    Key? key,
    required this.activeIndex,
    required this.onTabTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBottomNavigationBar(
      icons: const [
        Icons.home_outlined,
        Icons.favorite_border,
        Icons.access_time,
        Icons.person_outline,
      ],
      backgroundColor: isDark
          ? Color(0xFF2C2C2C)
          : Color(0xFFDBF4D1), // Background color changes based on theme
      activeIndex: activeIndex,
      gapLocation: GapLocation.center,
      activeColor: isDark
          ? Colors.white
          : AppConstants.buttonColor, // Active icon color based on theme
      inactiveColor: isDark
          ? Colors.white70
          : Colors.black54, // Inactive icon color based on theme
      notchSmoothness: NotchSmoothness.softEdge,
      shadow: BoxShadow(
        color: isDark
            ? Colors.black.withOpacity(0.3)
            : Colors.black.withOpacity(0.1), // Shadow color based on theme
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
      onTap: (index) => onTabTapped(index),
    );
  }
}
