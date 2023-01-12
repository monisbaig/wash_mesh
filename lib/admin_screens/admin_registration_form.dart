import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/admin_screens/admin_home_screen.dart';
import 'package:wash_mesh/user_screens/user_login_form.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';

import '../widgets/custom_colors.dart';
import '../widgets/custom_text_field.dart';

class AdminRegisterScreen extends StatefulWidget {
  const AdminRegisterScreen({Key? key}) : super(key: key);

  @override
  State<AdminRegisterScreen> createState() => _AdminRegisterScreenState();
}

class _AdminRegisterScreenState extends State<AdminRegisterScreen> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
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
                  'Service Provider',
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
                    const CustomTextField(hint: 'Email Address'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Phone No.*'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'CNIC No.*'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Password'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Confirm Password'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Experience in Years'),
                    SizedBox(height: 10.h),
                    const CustomTextField(hint: 'Referral Code'),
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
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 350.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: CustomColor().mainColor,
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColor().shadowColor2,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Experience Certificate',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 168.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: CustomColor().mainColor,
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor().shadowColor2,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'CNIC Front',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 168.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: CustomColor().mainColor,
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor().shadowColor2,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'CNIC Back',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35.h),
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
                      builder: (context) => const AdminHomeScreen(),
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
      op: 0.1,
    );
  }
}
// ElevatedButton.icon(
//   onPressed: () {},
//   label: const Text(
//     'CNIC Front',
//   ),
//   icon: const Icon(Icons.camera_alt_outlined),
// ),
