import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/admin_screens/admin_registration_form.dart';
import 'package:wash_mesh/user_screens/user_registration_form.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      ch: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 12.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const CustomLogo(),
            SizedBox(height: 50.h),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Register as a',
                  style: TextStyle(
                    fontSize: 25.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.h),
            CustomButton(
              onTextPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserRegistrationForm(),
                  ),
                );
              },
              buttonText: 'Customer',
              v: 15.h,
              h: 100.w,
            ),
            SizedBox(height: 30.h),
            CustomButton(
              onTextPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AdminRegisterScreen(),
                  ),
                );
              },
              buttonText: 'Service Provider',
              v: 15.h,
              h: 67.w,
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
      op: 0.1,
    );
  }
}
