import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOtp extends StatelessWidget {
  final String otpNumber;

  const CustomOtp({super.key, required this.otpNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          otpNumber,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.sp,
          ),
        ),
      ),
    );
  }
}
