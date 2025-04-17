import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimelineTile extends StatelessWidget {
  final bool isActive;
  final String text;
  final IconData icon;

  TimelineTile({
    required this.isActive,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 15,
              width: 2,
              color: isActive ? theme.colorScheme.primary : theme.dividerColor,
            ),
            CircleAvatar(
              backgroundColor: isActive
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surfaceVariant,
              child: Icon(
                icon,
                color: isActive
                    ? Colors.white
                    : theme.iconTheme.color?.withOpacity(0.5),
              ),
            ),
          ],
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ],
    );
  }
}
