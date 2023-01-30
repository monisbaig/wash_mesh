import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/models/customer_registration_model.dart';
import 'package:wash_mesh/providers/auth_provider.dart';
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
  final formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController address = TextEditingController();

  onRegister() async {
    final userData = Provider.of<AuthProvider>(context, listen: false);
    CustomerRegistrationModel customerData = CustomerRegistrationModel();
    try {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        final result = await userData.registerCustomer(
          customerData.data!.user!.firstName,

          // firstName: firstName.text,
          // lastName: lastName.text,
          // email: email.text,
          // phoneNo: phoneNo.text,
          // password: password.text,
          // confirmPassword: confirmPassword.text,
          // address: address.text,
        );
        firstName.clear();
        lastName.clear();
        email.clear();
        phoneNo.clear();
        password.clear();
        confirmPassword.clear();
        address.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result'),
          ),
        );

        if (result == 'Registered Successfully') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const UserLoginForm(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
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
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hint: 'First Name',
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
                      hint: 'Last Name',
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
                      hint: 'Email*',
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
                      hint: 'Phone No.*',
                      controller: phoneNo,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
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
                    SizedBox(height: 10.h),
                    CustomTextField(
                      hint: 'Confirm Password',
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
                      hint: 'Address',
                      controller: address,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
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
                onTextPress: onRegister,
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
