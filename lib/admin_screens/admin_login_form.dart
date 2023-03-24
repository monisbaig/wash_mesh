// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/admin_screens/admin_registration_form.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar_admin.dart';
import 'package:wash_mesh/widgets/custom_text_field.dart';

import '../admin_map_integration/admin_global_variables/admin_global_variables.dart';
import '../providers/admin_provider/admin_auth_provider.dart';
import 'admin_forget_password.dart';

class AdminLoginForm extends StatefulWidget {
  const AdminLoginForm({Key? key}) : super(key: key);

  @override
  State<AdminLoginForm> createState() => _AdminLoginFormState();
}

class _AdminLoginFormState extends State<AdminLoginForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();

  onSubmit() async {
    final adminData = Provider.of<AdminAuthProvider>(context, listen: false);
    try {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        final result = await adminData.loginAdmin(
          input: phoneNo.text,
          password: password.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result'),
          ),
        );

        if (result == 'Service Provider Logged in Successfully!') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("loginPhone", phoneNo.text);
          prefs.setString("loginPassword", password.text);

          login();

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const CustomNavigationBarAdmin(),
            ),
            (route) => false,
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AdminLoginForm(),
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email");

      final UserCredential admin =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email.toString(),
        password: password.text.trim(),
      );

      if (admin.user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('vendor');
        userRef.child(firebaseAuth.currentUser!.uid).once().then((adminKey) {
          final snap = adminKey.snapshot;
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

    if (p.getString("loginPhone") != null &&
        p.getString("loginPassword") != null) {
      phoneNo.text = p.getString("loginPhone")!;
      password.text = p.getString("loginPassword")!;
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
                        hint: 'phoneNo'.tr(),
                        controller: phoneNo,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
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
                            builder: (context) => const AdminRegisterScreen(),
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
                            builder: (context) => const AdminForgetPassword(),
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
                SizedBox(height: 160.h),
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
