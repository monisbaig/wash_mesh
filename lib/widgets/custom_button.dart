import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.onTextPress, required this.buttonText, super.key});

  final dynamic onTextPress;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: onTextPress,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              elevation: 12,
              shadowColor: CustomColor().shadowColor,
              backgroundColor: CustomColor().mainColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22.sp,
              ),
            ),
            child: Text(buttonText),
          ),
        ),
      ],
    );
  }
}
