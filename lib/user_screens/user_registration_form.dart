import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/user_screens/user_home_screen.dart';
import 'package:wash_mesh/user_screens/user_login_form.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';
import 'package:wash_mesh/widgets/custom_text_field.dart';

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({Key? key}) : super(key: key);

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
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
                  'Customer',
                  style: TextStyle(
                    fontSize: 25.sp,
                  ),
                ),
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
                    const CustomTextField(hint: 'Password'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Confirm Password'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Address'),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserLoginForm(),
                    ),
                  );
                },
                child: Text(
                  'Already have an account',
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/google-logo.png', height: 40.h),
                  SizedBox(width: 16.w),
                  Image.asset('assets/images/facebook-logo.png', height: 40.h),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  Text(
                    'Terms and conditions',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              CustomButton(
                onTextPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserHomeScreen(),
                    ),
                  );
                },
                buttonText: 'SIGN IN',
                v: 15.h,
                h: 110.w,
              ),
              SizedBox(height: 33.h),
            ],
          ),
        ),
      ),
    );
  }
}
