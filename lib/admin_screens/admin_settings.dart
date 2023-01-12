import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/admin_screens/admin_profile.dart';

import '../widgets/custom_colors.dart';
import '../widgets/custom_logo.dart';
import '../widgets/custom_navigation_bar_admin.dart';
import 'admin_app_language.dart';
import 'admin_change_password.dart';

class AdminSettings extends StatelessWidget {
  const AdminSettings({Key? key}) : super(key: key);

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
                'Settings',
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/settings.png',
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(height: 90.h),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminProfile(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 60.h,
                decoration: BoxDecoration(
                  color: CustomColor().mainColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.perm_contact_cal_outlined,
                      size: 30.sp,
                      color: Colors.white,
                    ),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 65.w),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 25.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminAppLanguage(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 60.h,
                decoration: BoxDecoration(
                  color: CustomColor().mainColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.language_outlined,
                      size: 30.sp,
                      color: Colors.white,
                    ),
                    Text(
                      'App Language',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 25.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminChangePassword(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 60.h,
                decoration: BoxDecoration(
                  color: CustomColor().mainColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.lock,
                      size: 30.sp,
                      color: Colors.white,
                    ),
                    Text(
                      'Change Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22.sp,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 25.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 60.h,
                decoration: BoxDecoration(
                  color: CustomColor().mainColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.error_outline_outlined,
                      size: 30.sp,
                      color: Colors.white,
                    ),
                    Text(
                      'About',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 100.w),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 25.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 90.h),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: CustomColor().mainColor,
              ),
            ),
            const Text(
              'V 5.0.0',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }
}
