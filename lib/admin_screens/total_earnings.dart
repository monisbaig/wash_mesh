import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_background.dart';
import '../widgets/custom_logo.dart';

class TotalEarningsScreen extends StatelessWidget {
  TotalEarningsScreen({Key? key}) : super(key: key);

  final List items = [
    '1: Completed Service : 10rs',
    '2: Completed Service : 20rs',
    '3: Completed Service : 30rs',
    '4: Completed Service : 40rs',
    '5: Completed Service : 50rs',
    '6: Completed Service : 60rs',
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
                Container(
                  width: 300.w,
                  height: 450.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: GridView.builder(
                      itemCount: items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisExtent: 35,
                      ),
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(items[index]),
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 30.h),
                // CustomButton(
                //   onTextPress: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => const UserHomeScreen(),
                //       ),
                //     );
                //   },
                //   buttonText: 'OK',
                //   v: 15.h,
                //   h: 140.w,
                // ),
                // SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
