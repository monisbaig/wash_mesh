import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/user_screens/user_login_form.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';
import 'package:wash_mesh/widgets/custom_text_field.dart';

import '../models/user_models/user_registration_model.dart';
import '../providers/admin_provider/admin_auth_provider.dart';
import '../providers/user_provider/user_auth_provider.dart';
import '../widgets/custom_navigation_bar.dart';

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({Key? key}) : super(key: key);

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  bool? isChecked = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController address = TextEditingController();
  dynamic selectedGender;
  List gender = [
    'Male',
    'Female',
  ];

  onRegister() async {
    final userData = Provider.of<UserAuthProvider>(context, listen: false);
    try {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        User user = User(
          firstName: firstName.text,
          lastName: lastName.text,
          email: email.text,
          password: password.text,
          confirmPassword: confirmPassword.text,
          address: address.text,
          phone: phoneNo.text,
        );
        userData.registerUser(user);

        firstName.clear();
        lastName.clear();
        email.clear();
        phoneNo.clear();
        password.clear();
        confirmPassword.clear();
        address.clear();

        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(
            content: Text('${userData.registerUser(user)}'),
          ),
        );

        if (userData.registerUser(user) == 'Registered Successfully') {
          Navigator.of(context as BuildContext).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const UserLoginForm(),
            ),
          );
        } else {
          Navigator.of(context as BuildContext).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const UserRegistrationForm(),
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
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 15.w),
            child: Column(
              children: [
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
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        hint: 'firstName'.tr(),
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
                        controller: firstName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'lastName'.tr(),
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
                        controller: lastName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'email'.tr(),
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
                        controller: email,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please enter your email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'phoneNo'.tr(),
                        controller: phoneNo,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'password'.tr(),
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Please enter your password with at least 5 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'confirmPassword'.tr(),
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
                        controller: confirmPassword,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Please re-enter your password';
                          } else if (password.text != confirmPassword.text) {
                            return "password doesn't match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'address'.tr(),
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
                        controller: address,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32.r),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedGender,
                          hint: const Text(
                            'Gender',
                            style: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select your gender';
                            }
                            return null;
                          },
                          items: gender
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          borderRadius: BorderRadius.circular(32.r),
                          onChanged: (String? value) {
                            selectedGender = value!;
                          },
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.r),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.r),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.r),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(32.r),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UserLoginForm(),
                      ),
                    );
                  },
                  child: Text(
                    'alreadyAccount'.tr(),
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ),
                SizedBox(height: 15.h),
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
                    Image.asset('assets/images/facebook-logo.png',
                        height: 40.h),
                  ],
                ),
                SizedBox(height: 15.h),
                if (isChecked == false)
                  Text(
                    'Select Terms and conditions',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade500,
                    ),
                  ),
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
                      'Terms and conditions*',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  onTextPress: isChecked == true ? onRegister : null,
                  buttonText: 'SIGN UP',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
