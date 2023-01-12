import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/admin_screens/admin_home_screen.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_logo.dart';
import '../widgets/custom_navigation_bar_admin.dart';
import '../widgets/custom_text_field.dart';

class AdminChangePassword extends StatelessWidget {
  const AdminChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNavigationBarAdmin(
      op: 0.1,
      ch: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 33.h),
            const CustomLogo(),
            SizedBox(height: 15.h),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            const CustomTextField(hint: 'Enter your old Password'),
            SizedBox(height: 10.h),
            const CustomTextField(hint: 'Enter your new Password'),
            SizedBox(height: 10.h),
            const CustomTextField(hint: 'Re-enter your new Password'),
            SizedBox(height: 40.h),
            CustomButton(
              onTextPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminHomeScreen(),
                  ),
                );
              },
              buttonText: 'Confirm',
              v: 15.h,
              h: 110.w,
            ),
            SizedBox(height: 33.h),
          ],
        ),
      ),
    );
  }
}
