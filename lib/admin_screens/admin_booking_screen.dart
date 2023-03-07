import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/admin_screens/admin_orders_screen.dart';

import '../widgets/custom_background.dart';
import '../widgets/custom_logo.dart';

class AdminBookingScreen extends StatefulWidget {
  const AdminBookingScreen({Key? key}) : super(key: key);

  @override
  State<AdminBookingScreen> createState() => _AdminBookingScreenState();
}

class _AdminBookingScreenState extends State<AdminBookingScreen> {
  final List items = [
    'All',
    'Pending',
    'Accept',
    'On Going',
    'In Progress',
    'Hold',
    'Cancelled',
    'Rejected',
    'Failed',
    'Completed',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 12.w),
            child: Column(
              children: [
                const CustomLogo(),
                SizedBox(height: 15.h),
                Image.asset('assets/images/booking.png'),
                SizedBox(height: 30.h),
                SizedBox(
                  width: 300.w,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminOrdersScreen(),
                        ),
                      );
                    },
                    child: const Text('Vendor Orders Screen'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
