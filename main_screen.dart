import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/controller/cart_controller.dart';
import 'package:foodtek/section5/profile1.dart';
import 'package:foodtek/section5/track.dart';
import 'package:foodtek/view/screens/cart_screens/cart_main_screen.dart';
import 'package:foodtek/view/screens/favourite_screen.dart';
import 'package:foodtek/view/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../../app_constants.dart';
import '../widgets/main_widgets/main_app_bar_widget.dart';
import '../widgets/main_widgets/main_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int activeIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    FavouriteScreen(),
    TrackPage(),
    Prof(),
    CartMainScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(),
      body: pages[activeIndex],
      bottomNavigationBar: MainBottomNavigationBar(
        activeIndex: activeIndex,
        onTabTapped: (index) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          activeIndex = 4;
        });
      },
      backgroundColor: Theme.of(context).colorScheme.primary, // dynamic color
      elevation: 0,
      shape: const CircleBorder(),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.shopping_cart_outlined,
              color:
                  Theme.of(context).colorScheme.onPrimary, // dynamic icon color
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: 20.h,
              width: 20.w,
              child: Consumer<CartController>(
                builder: (context, cartController, _) {
                  final itemCount = cartController.cartItems.length;
                  if (itemCount == 0) {
                    return SizedBox.shrink();
                  } else {
                    return CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.2), // dynamic badge color
                      child: Text(
                        "$itemCount",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .primary, // text color dynamic
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
