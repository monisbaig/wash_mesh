import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/recreate_password.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';

import '../widgets/custom_otp.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: Center(
        child: Column(
          children: [
            const CustomLogo(),
            SizedBox(height: 15.h),
            Container(
              alignment: Alignment.center,
              child: Text(
                'O.T.P',
                style: TextStyle(
                  fontSize: 25.sp,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CustomOtp(otpNumber: '9'),
                CustomOtp(otpNumber: '4'),
                CustomOtp(otpNumber: '8'),
                CustomOtp(otpNumber: '5'),
              ],
            ),
            SizedBox(height: 25.h),
            Text(
              'Resend Within 45s',
              style: TextStyle(
                fontSize: 17.sp,
              ),
            ),
            Expanded(child: SizedBox(height: 40.h)),
            CustomButton(
              onTextPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RecreatePassword(),
                  ),
                );
              },
              buttonText: 'VERIFY',
              v: 15.h,
              h: 120.w,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
