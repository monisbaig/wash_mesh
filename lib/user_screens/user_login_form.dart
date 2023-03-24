// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/user_screens/user_forget_password.dart';
import 'package:wash_mesh/user_screens/user_registration_form.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';
import 'package:wash_mesh/widgets/custom_text_field.dart';

import '../providers/admin_provider/admin_auth_provider.dart';
import '../providers/user_provider/user_auth_provider.dart';
import '../user_map_integration/assistants/user_assistant_methods.dart';
import '../user_map_integration/user_global_variables/user_global_variables.dart';
import '../widgets/custom_navigation_bar.dart';

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

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('$result'),
        //   ),
        // );

        if (result == 'Login Successfully') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("userEmail", emailPhone.text);
          prefs.setString("userPassword", password.text);

          login();

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const CustomNavigationBar(),
            ),
            (route) => false,
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

  void login() async {
    try {
      final UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
        email: emailPhone.text.trim(),
        password: password.text.trim(),
      );

      if (user.user != null) {
        UserAssistantMethods.readCurrentOnlineUserInfo();

        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('users');
        userRef.child(firebaseAuth.currentUser!.uid).once().then((userKey) {
          final snap = userKey.snapshot;
          if (snap.value != null) {
            Fluttertoast.showToast(msg: 'Login Successfully');
          } else {
            Fluttertoast.showToast(msg: 'No record exist with this email.');
          }
        });
      } else {
        Fluttertoast.showToast(msg: 'Login Failed, Check your credentials.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  checkPassword() async {
    SharedPreferences p = await SharedPreferences.getInstance();

    if (p.getString("userEmail") != null &&
        p.getString("userPassword") != null) {
      emailPhone.text = p.getString("userEmail")!;
      password.text = p.getString("userPassword")!;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    checkPassword();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                        hint: 'emailPhone'.tr(),
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
                        hint: 'password'.tr(),
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Please enter your password with at least 6 characters';
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UserRegistrationForm(),
                          ),
                        );
                      },
                      child: Text(
                        'Signup Now',
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
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
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        await Provider.of<AdminAuthProvider>(context,
                                listen: false)
                            .signInWithGoogle();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const CustomNavigationBar(),
                          ),
                        );
                      },
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
                SizedBox(height: 60.h),
                CustomButton(
                  onTextPress: onSubmit,
                  buttonText: 'LOG IN',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
