import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get current theme

    return Scaffold(
      backgroundColor: theme.colorScheme.background, // Background color from theme
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Row(
                children: [
                  SizedBox(width: 15.w),
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("assets/images/man2.png"),
              ),
              SizedBox(height: 8.h),
              Text(
                'Ahmad Daboor',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Text('ahmad1709@gmail.com',
                  style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                height: 416,
                width: 380,
                decoration: BoxDecoration(
                  color: theme.cardColor, // Card color from theme
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 0.8, color: theme.dividerColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username ",
                      style: TextStyle(
                        color: theme.textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      width: 356.w,
                      height: 46.h,
                      child: TextField(
                        controller: email,
                        style: TextStyle(
                            color: theme.textTheme.bodyLarge
                                ?.color), // Text color from theme
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "Ahmad Daboor",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color:
                                theme.hintColor, // Hint text color from theme
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color:
                                  theme.dividerColor, // Border color from theme
                              width: 1.w,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: theme.dividerColor,
                              width: 1.w,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: theme
                                  .primaryColor, // Focused border color from theme
                              width: 1.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    // Repeat the above for other fields
                    // Make sure to use theme for colors and styles dynamically
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: SizedBox(
                  width: 295.w,
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor, // Button color from theme
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
