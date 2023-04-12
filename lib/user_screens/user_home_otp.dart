// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:wash_mesh/user_screens/user_login_form.dart';
import 'package:wash_mesh/user_screens/user_registration_form.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';

class UserHomeOTP extends StatefulWidget {
  const UserHomeOTP({Key? key}) : super(key: key);

  @override
  State<UserHomeOTP> createState() => _UserHomeOTPState();
}

class _UserHomeOTPState extends State<UserHomeOTP> {
  var smsCode = '';

  otpVerify() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: UserRegistrationForm.verify,
        smsCode: smsCode,
      );
      // await auth.signInWithCredential(credential);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const UserLoginForm(),
        ),
        (route) => false,
      );
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const UserLoginForm(),
        ),
        (route) => false,
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return CustomBackground(
      op: 0.1,
      ch: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 12.w),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 340.w,
                    child: Pinput(
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      length: 6,
                      showCursor: true,
                      onChanged: (value) {
                        smsCode = value;
                      },
                    ),
                  )
                ],
              ),
              Expanded(child: Container()),
              CustomButton(
                onTextPress: otpVerify,
                buttonText: 'VERIFY',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
