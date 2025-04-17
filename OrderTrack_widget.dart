import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTrackStatusWidget extends StatelessWidget {
  const OrderTrackStatusWidget({super.key, required this.title, this.value});

  final String title;
  final double? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      children: [
        Text(
          title,
          style: theme.textTheme.displaySmall!.copyWith(
            color: value == 1
                ? (isDarkMode ? Colors.greenAccent : Colors.green)
                : (isDarkMode ? Colors.white60 : Color(0xff878787)),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 5.h),
        LinearProgressIndicator(
          backgroundColor: isDarkMode ? Colors.grey[800] : Color(0xff878787),
          value: value,
          valueColor: AlwaysStoppedAnimation<Color>(
            isDarkMode ? Colors.greenAccent : Colors.green,
          ),
        ),
      ],
    );
  }
}
