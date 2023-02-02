import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/user_screens/user_booking_screen.dart';
import 'package:wash_mesh/user_screens/user_home_screen.dart';
import 'package:wash_mesh/user_screens/user_settings.dart';
import 'package:wash_mesh/user_screens/wash_book_screen.dart';
import 'package:wash_mesh/user_screens/wash_category_screen.dart';
import 'package:wash_mesh/widgets/custom_colors.dart';

class CustomNavigationBar extends StatefulWidget {
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  List pages = [
    UserBookingScreen(),
    const WashCategory(),
    const UserHomeScreen(),
    const UserHomeScreen(),
    const UserSettings(),
  ];

  int currentIndex = 2;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _showCategory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.sp,
                ),
              ),
              SizedBox(height: 280.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const WashBookScreen(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/wash.png',
                      width: 130.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/mesh.png',
                      width: 130.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: CustomColor().mainTheme,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: CurvedNavigationBar(
          index: currentIndex,
          animationDuration: const Duration(milliseconds: 300),
          onTap: onTap,
          items: [
            Icon(
              Icons.event_note_outlined,
              color: CustomColor().mainColor,
            ),
            Icon(
              Icons.category_outlined,
              color: CustomColor().mainColor,
            ),
            Icon(
              Icons.home,
              color: CustomColor().mainColor,
            ),
            Icon(
              Icons.chat_bubble_outlined,
              color: CustomColor().mainColor,
            ),
            Icon(
              Icons.settings,
              color: CustomColor().mainColor,
            ),
          ],
        ),
        body: pages[currentIndex],
      ),
    );
  }
}
