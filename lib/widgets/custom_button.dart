import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.onTextPress,
      required this.buttonText,
      required this.v,
      required this.h,
      super.key});

  final  onTextPress;
  final String buttonText;
  final double v;
  final double h;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTextPress,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: v, horizontal: h),
        elevation: 12,
        shadowColor: CustomColor().shadowColor,
        backgroundColor: CustomColor().mainColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22.sp,
        ),
      ),
      child: Text(buttonText),
    );
  }
}
