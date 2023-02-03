import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/user_screens/user_app_language.dart';
import 'package:wash_mesh/user_screens/user_change_password.dart';
import 'package:wash_mesh/user_screens/user_login_form.dart';
import 'package:wash_mesh/user_screens/user_profile.dart';
import 'package:wash_mesh/widgets/custom_background.dart';

import '../widgets/custom_colors.dart';
import '../widgets/custom_logo.dart';

class UserSettings extends StatelessWidget {
  const UserSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 12.w),
          child: Column(
            children: [
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
                      builder: (context) => const UserProfile(),
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 25.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserAppLanguage(),
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 25.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserChangePassword(),
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 25.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 90.h),
              InkWell(
                onTap: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const UserLoginForm(),
                    ),
                  );
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('token');
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: CustomColor().mainColor,
                  ),
                ),
              ),
              const Text(
                'V 5.0.0',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
