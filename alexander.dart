import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'chat_page.dart';

class Alexander extends StatefulWidget {
  const Alexander({super.key});

  @override
  State<Alexander> createState() => _AlexanderState();
}

class _AlexanderState extends State<Alexander> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // للحصول على الثيم الحالي

    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/photo man.png'),
          ),
          title: Text(
            'Your Delivery Hero',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.hintColor, // لون رمادي مناسب
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                'Aleksandr V.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      ' 4.9',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: theme.cardColor,
                ),
                child: Icon(Icons.phone, color: Colors.green),
              ),
              SizedBox(width: 10.w),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: theme.cardColor,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                  },
                  icon: Icon(Icons.message, color: Colors.orange),
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 1.h, width: double.infinity, color: theme.dividerColor),
        SizedBox(height: 10.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Location",
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.hintColor,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(Icons.location_on_outlined,
                    color: theme.colorScheme.primary),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    "123 Al-Madina Street, Abdali, Amman, Jordan",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
