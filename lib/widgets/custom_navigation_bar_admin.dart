import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wash_mesh/admin_chat_module/screens/admin_auth_screen.dart';
import 'package:wash_mesh/admin_screens/admin_home_screen.dart';
import 'package:wash_mesh/admin_screens/admin_services.dart';
import 'package:wash_mesh/admin_screens/admin_settings.dart';
import 'package:wash_mesh/user_screens/user_booking_screen.dart';
import 'package:wash_mesh/widgets/custom_colors.dart';

class CustomNavigationBarAdmin extends StatefulWidget {
  const CustomNavigationBarAdmin({super.key});

  @override
  State<CustomNavigationBarAdmin> createState() =>
      _CustomNavigationBarAdminState();
}

class _CustomNavigationBarAdminState extends State<CustomNavigationBarAdmin> {
  List pages = [
    UserBookingScreen(),
    const AdminServices(),
    const AdminHomeScreen(),
    const AdminAuthScreen(),
    const AdminSettings(),
  ];

  int currentIndex = 2;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
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
