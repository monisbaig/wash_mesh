import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/user_screens/user_home_screen.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';
import 'package:wash_mesh/widgets/custom_text_field.dart';

class RecreatePassword extends StatefulWidget {
  const RecreatePassword({Key? key}) : super(key: key);

  @override
  State<RecreatePassword> createState() => _RecreatePasswordState();
}

class _RecreatePasswordState extends State<RecreatePassword> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const CustomLogo(),
              SizedBox(height: 15.h),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Re-Create Password',
                  style: TextStyle(
                    fontSize: 25.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Image.asset('assets/images/pngegg.png'),
              SizedBox(height: 30.h),
              Form(
                child: Column(
                  children: [
                    const CustomTextField(hint: 'Enter Password'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Confirm Password'),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              SizedBox(height: 227.h),
              CustomButton(
                onTextPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserHomeScreen(),
                    ),
                  );
                },
                buttonText: 'OK',
                v: 15.h,
                h: 140.w,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
