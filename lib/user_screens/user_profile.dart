import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_logo.dart';
import '../widgets/custom_navigation_bar.dart';
import '../widgets/custom_text_field.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(
      op: 0.1,
      ch: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 33.h),
              const CustomLogo(),
              SizedBox(height: 15.h),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'User Profile',
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
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Form(
                child: Column(
                  children: [
                    const CustomTextField(hint: 'First Name'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Last Name'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Email*'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Phone No.*'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Place'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Address'),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              CustomButton(
                onTextPress: () {},
                buttonText: 'Save Changes',
                v: 15.h,
                h: 90.w,
              ),
              SizedBox(height: 33.h),
            ],
          ),
        ),
      ),
    );
  }
}
