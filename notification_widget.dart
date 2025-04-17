import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../app_style.dart';
import '../../../controller/home_page_controller.dart';
import '../../../controller/lang_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../../model/notification_item.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homePageController = Provider.of<HomePageController>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.background, // Use background color based on theme
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          _buildAppBar(context, theme),
          _buildToggleButtons(homePageController, context),
          Expanded(
            child: NotificationList(
              notifications: homePageController.getFilteredNotifications(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ThemeData theme) {
    LangController langController =
        Provider.of<LangController>(context, listen: false);
    return AppBar(
      centerTitle: true,
      backgroundColor: theme.appBarTheme
          .backgroundColor, // Use appBar background color based on theme
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu_outlined, color: theme.iconTheme.color),
        ),
      ],
      title: Text(
        AppLocalizations.of(context)!.notifications,
        style: AppStyles.getFontStyle(
          langController,
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
          color: theme.textTheme.bodyLarge?.color ?? Colors.black, // Use text color based on theme
        ),
      ),
    );
  }

  Widget _buildToggleButtons(
      HomePageController controller, BuildContext context) {
    final theme = Theme.of(context);
    return ToggleButtons(
      borderRadius: BorderRadius.circular(8),
      borderWidth: 0,
      borderColor: Colors.transparent,
      selectedBorderColor: Colors.transparent,
      fillColor: Colors.transparent,
      selectedColor: AppConstants.buttonColor,
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
        color: theme
            .textTheme.bodyLarge?.color, // Use bodyText color based on theme
      ),
      isSelected: [
        controller.selectedToggleIndex == 0,
        controller.selectedToggleIndex == 1,
        controller.selectedToggleIndex == 2,
      ],
      onPressed: (int index) {
        controller.updateSelectedToggleIndex(index);
      },
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(AppLocalizations.of(context)!.all_tab),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(AppLocalizations.of(context)!.unread_tab),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(AppLocalizations.of(context)!.read_tab),
        ),
      ],
    );
  }
}

class NotificationList extends StatelessWidget {
  final List<NotificationItem> notifications;

  const NotificationList({Key? key, required this.notifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (notifications.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.no_notification,
          style: TextStyle(
            fontSize: 16.sp,
            color: theme.textTheme.bodyMedium?.color ??
                Colors.grey, // Use text color based on theme
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationCard(notification: notification);
      },
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationCard({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: theme.dividerColor,
            width: .3), // Use divider color based on theme
        color: theme.cardColor, // Use card color based on theme
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color ?? Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              notification.message,
              style: TextStyle(
                  color: theme.textTheme.bodyMedium?.color ?? Colors.black54),
            ),
            SizedBox(height: 8),
            Text(
              notification.date,
              style: TextStyle(
                  color: theme.textTheme.bodyMedium?.color ?? Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
