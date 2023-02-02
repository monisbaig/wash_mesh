import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/user_screens/user_forget_password.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar.dart';
import 'package:wash_mesh/widgets/custom_text_field.dart';

import '../providers/user_provider/user_auth_provider.dart';

class UserLoginForm extends StatefulWidget {
  const UserLoginForm({Key? key}) : super(key: key);

  @override
  State<UserLoginForm> createState() => _UserLoginFormState();
}

class _UserLoginFormState extends State<UserLoginForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailPhone = TextEditingController();
  TextEditingController password = TextEditingController();

  onSubmit() async {
    final userData = Provider.of<UserAuthProvider>(context, listen: false);
    try {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        final result = await userData.loginUser(
          input: emailPhone.text,
          password: password.text,
        );
        emailPhone.clear();
        password.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result'),
          ),
        );

        if (result == 'Login Successfully') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => CustomNavigationBar(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const UserLoginForm(),
            ),
          );
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              const CustomLogo(),
              SizedBox(height: 15.h),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 25.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Image.asset('assets/images/pngegg.png'),
              SizedBox(height: 30.h),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hint: 'Email / Phone No',
                      controller: emailPhone,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hint: 'Password',
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Please enter your password with at least 5 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UserForgetPassword(),
                        ),
                      );
                    },
                    child: Text(
                      'Forget Password',
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image.asset('assets/images/google-logo.png',
                        height: 40.h),
                  ),
                  SizedBox(width: 16.w),
                  InkWell(
                    onTap: () {},
                    child: Image.asset('assets/images/facebook-logo.png',
                        height: 40.h),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'Continue with',
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 40.h),
              CustomButton(
                onTextPress: onSubmit,
                buttonText: 'LOG IN',
                v: 15.h,
                h: 120.w,
              ),
              SizedBox(height: 33.h),
            ],
          ),
        ),
      ),
    );
  }
}
