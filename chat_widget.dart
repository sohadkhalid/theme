import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatViewWidget extends StatelessWidget {
  final List<String> messages;

  ChatViewWidget({required this.messages});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: messages.length,
      reverse: true,
      itemBuilder: (context, index) {
        final isSender = index % 2 == 0;

        return Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              decoration: BoxDecoration(
                color: isSender
                    ? theme.colorScheme.primary
                    : theme.cardColor, // خلفية الرسالة المستلمة
                borderRadius: isSender
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
              ),
              child: Text(
                messages[index],
                style: TextStyle(
                  color: isSender
                      ? Colors.white
                      : theme.textTheme.bodyMedium?.color ??
                          theme.colorScheme.onSurface,
                  fontSize: 13.sp,
                  fontWeight: isSender ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        );
      },
    );
  }
}
