import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/providers/auth_provider.dart';
import 'package:wash_mesh/user_screens/user_login_form.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_button.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({Key? key}) : super(key: key);

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  bool? isChecked = false;
  final formKey = GlobalKey<FormFieldState>();

  var _firstName = '';
  var _lastName = '';
  var _email = '';
  var _phoneNo = '';
  var _password = '';
  var _confirmPassword = '';
  var _address = '';

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController address = TextEditingController();

  Future<void> onSubmit() async {
    formKey.currentState?.save();
    final userData = Provider.of<AuthProvider>(context, listen: false);
    final result = await userData.registerUser(
      firstName: firstName.text,
      lastName: lastName.text,
      email: email.text,
      phoneNo: phoneNo.text,
      password: password.text,
      confirmPassword: confirmPassword.text,
      address: address.text,
    );
    return result;
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
                    TextFormField(
                      key: const ValueKey('firstName'),
                      controller: firstName,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSaved: (firstName) {
                        _firstName = firstName!;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      key: const ValueKey('lastName'),
                      controller: lastName,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSaved: (lastName) {
                        _lastName = lastName!;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      key: const ValueKey('email'),
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'Email*',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSaved: (email) {
                        _email = email!;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      key: const ValueKey('phoneNo'),
                      controller: phoneNo,
                      decoration: InputDecoration(
                        hintText: 'Phone No.*',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSaved: (phoneNo) {
                        _phoneNo = phoneNo!;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      key: const ValueKey('password'),
                      controller: password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSaved: (password) {
                        _password = password!;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      key: const ValueKey('confirmPassword'),
                      controller: confirmPassword,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSaved: (confirmPassword) {
                        _confirmPassword = confirmPassword!;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      key: const ValueKey('address'),
                      controller: address,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSaved: (address) {
                        _address = address!;
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
                onTextPress: onSubmit,
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
