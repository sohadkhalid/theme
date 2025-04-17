import 'package:flutter/material.dart';
import 'notification_widget.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: isDark
              ? Color(0xFF3C3C3C)
              : Color(0xFFF5F5F5), // Background color changes based on theme
          borderRadius: BorderRadius.circular(4),
        ),
        child: IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return NotificationWidget();
              },
            );
          },
          icon: Image.asset(
            "assets/images/notification.png",
            height: 22,
            width: 22,
            color: isDark
                ? Colors.white
                : Colors.black, // Icon color changes based on theme
          ),
        ),
      ),
    );
  }
}
