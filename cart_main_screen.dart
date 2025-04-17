import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/app_constants.dart';
import 'package:foodtek/view/screens/history_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cart_screen.dart';

class CartMainScreen extends StatelessWidget {
  const CartMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor ??
              theme.scaffoldBackgroundColor,
          elevation: 0,
          title: TabBar(
            tabs: [
              Tab(text: "Cart"),
              Tab(text: "History"),
            ],
            labelColor: AppConstants.buttonColor,
            unselectedLabelColor:
                theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
            indicatorColor: AppConstants.buttonColor,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            CartScreen(),
            HistoryScreen(),
          ],
        ),
      ),
    );
  }
}
