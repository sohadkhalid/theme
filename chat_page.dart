import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'chat_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // للحصول على الثيم الحالي

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 25),
            child: Column(
              children: [
                SizedBox(height: 35.h),
                Row(
                  children: [
                    IconButton(
                      icon:
                          Icon(Icons.arrow_back, color: theme.iconTheme.color),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      "Chat",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
                Divider(color: theme.dividerColor, height: 1.h),
                Expanded(
                  child: ChatViewWidget(
                    messages: [
                      " Hello chatGPT,how are you today?",
                      "There are many programming languages \n​​in the market that are used in designing \n and building websites, various\n applications and other tasks. All these \n languages ​​are popular in their place and \n in the way they are used, and many \n programmers learn and use them.",
                      "So explain to me more",
                      "There are many programming languages \n​​in the market that are used in designing \n and building websites, various\n applications and other tasks. All these \n languages ​​are popular in their place and \n in the way they are used, and many \n programmers learn and use them.",
                      "What is the best programming language?",
                      "Hello,i’m fine,how can i help you?",
                      "Hello chatGPT,how are you today?",
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            right: 24,
            child: Container(
              width: 333.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: theme.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: "Write your message",
                        hintStyle: theme.textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: theme.colorScheme.primary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 65.w,
              height: 65.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
