import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/admin_screens/admin_home_screen.dart';
import 'package:wash_mesh/admin_screens/admin_services.dart';
import 'package:wash_mesh/admin_screens/admin_settings.dart';
import 'package:wash_mesh/user_screens/booking_screen.dart';
import 'package:wash_mesh/widgets/custom_colors.dart';

class CustomNavigationBarAdmin extends StatefulWidget {
  final Widget ch;
  final double op;

  const CustomNavigationBarAdmin(
      {super.key, required this.ch, required this.op});

  @override
  State<CustomNavigationBarAdmin> createState() =>
      _CustomNavigationBarAdminState();
}

class _CustomNavigationBarAdminState extends State<CustomNavigationBarAdmin> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

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
                    fontSize: 30.sp),
              ),
              SizedBox(height: 280.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AdminServices(),
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
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AdminServices(),
                        ),
                      );
                    },
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: CustomColor().mainTheme,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: CurvedNavigationBar(
          height: 70.h,
          index: 2,
          key: _bottomNavigationKey,
          letIndexChange: (value) => true,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            _page = index;
            if (_page == 0) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookingScreen(),
                ),
              );
            }
            if (_page == 1) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AdminServices(),
                ),
              );
            }
            if (_page == 2) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AdminHomeScreen(),
                ),
              );
            }
            if (_page == 3) {}
            if (_page == 4) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AdminSettings(),
                ),
              );
            }
          },
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 11.w),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: widget.op,
                  image: const AssetImage(
                    'assets/images/app-icon.png',
                  ),
                ),
              ),
              child: widget.ch,
            ),
          ),
        ),
      ),
    );
  }
}
