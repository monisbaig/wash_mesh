import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/admin_screens/admin_login_form.dart';
import 'package:wash_mesh/models/admin_models/admin_registration_model.dart';
import 'package:wash_mesh/providers/admin_provider/admin_auth_provider.dart';
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
  final formKey = GlobalKey<FormState>();
  File? expCert;
  File? cnicFront;
  File? cnicBack;
  dynamic base64ImageExp;
  dynamic base64ImageF;
  dynamic base64ImageB;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController cnicNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController gender = TextEditingController();

  experienceCert() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
    );
    if (imageFile == null) {
      return;
    }
    expCert = File(imageFile.path);
    final imageByte = expCert!.readAsBytesSync();
    setState(() {
      base64ImageExp = "data:image/png;base64,${base64Encode(imageByte)}";
    });
  }

  cnicFrontImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
    );
    if (imageFile == null) {
      return;
    }
    cnicFront = File(imageFile.path);
    final imageByte = cnicFront!.readAsBytesSync();
    setState(() {
      base64ImageF = "data:image/png;base64,${base64Encode(imageByte)}";
    });
  }

  cnicBackImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
    );
    if (imageFile == null) {
      return;
    }
    cnicBack = File(imageFile.path);
    final imageByte = cnicBack!.readAsBytesSync();
    setState(() {
      base64ImageB = "data:image/png;base64,${base64Encode(imageByte)}";
    });
  }

  onRegister() async {
    final adminData = Provider.of<AdminAuthProvider>(context, listen: false);
    try {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        VendorDetails vendorDetails = VendorDetails(
          gender: gender.text,
          experience: experience.text,
          cnic: cnicNo.text,
          experienceCertImg: base64ImageExp,
          cnicFrontImg: base64ImageF,
          cnicBackImg: base64ImageB,
        );

        Vendor vendor = Vendor(
          firstName: firstName.text,
          lastName: lastName.text,
          userName: userName.text,
          phone: phoneNo.text,
          address: address.text,
          password: password.text,
          confirmPassword: confirmPassword.text,
          referralCode: code.text,
          vendorDetails: vendorDetails,
        );

        await adminData.registerAdmin(vendor);

        firstName.clear();
        lastName.clear();
        userName.clear();
        phoneNo.clear();
        cnicNo.clear();
        password.clear();
        confirmPassword.clear();
        experience.clear();
        code.clear();
        address.clear();
        gender.clear();
        base64ImageExp = '';
        base64ImageF = '';
        base64ImageB = '';

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('${adminData.registerAdmin(vendor)}'),
        //   ),
        // );
        //
        // if (adminData.registerAdmin(vendor) ==
        //     'Vendor Socialite Registered Successfully') {
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(
        //       builder: (context) => const AdminLoginForm(),
        //     ),
        //   );
        // } else {
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(
        //       builder: (context) => const AdminRegisterScreen(),
        //     ),
        //   );
        // }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
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
                    'Service Provider',
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
                        hint: 'User Name',
                        controller: userName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your user name';
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
                            return 'Please enter your phone name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'CNIC No.*',
                        controller: cnicNo,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 13) {
                            return 'Please enter your cnic number';
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
                        hint: 'Experience in Years',
                        controller: experience,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'Referral Code',
                        controller: code,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
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
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: '1 for male, 2 for female',
                        controller: gender,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your gender';
                          }
                          return null;
                        },
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       padding: const EdgeInsets.all(12),
                      //       width: 415.h,
                      //       height: 70.h,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(20.r),
                      //       ),
                      //       child: DropdownButton(
                      //         borderRadius: BorderRadius.circular(20.r),
                      //         alignment: Alignment.center,
                      //         hint: const Text('Gender'),
                      //         icon: const Icon(
                      //           Icons.arrow_drop_down,
                      //           color: Colors.black,
                      //         ),
                      //         items: const [
                      //           DropdownMenuItem(
                      //             value: 'male',
                      //             child: Text('Male'),
                      //           ),
                      //           DropdownMenuItem(
                      //             value: 'female',
                      //             child: Text('Female'),
                      //           ),
                      //         ],
                      //         onChanged: (String? value) {},
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AdminLoginForm(),
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
                SizedBox(height: 20.h),
                InkWell(
                  onTap: experienceCert,
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
                      onTap: cnicFrontImage,
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
                      onTap: cnicBackImage,
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
                    Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: expCert != null
                          ? Image.file(
                              expCert!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : const Text(
                              'No Image Taken',
                              textAlign: TextAlign.center,
                            ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: cnicFront != null
                          ? Image.file(
                              cnicFront!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : const Text(
                              'No Image Taken',
                              textAlign: TextAlign.center,
                            ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: cnicBack != null
                          ? Image.file(
                              cnicBack!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : const Text(
                              'No Image Taken',
                              textAlign: TextAlign.center,
                            ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 35.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google-logo.png', height: 40.h),
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
                  onTextPress: isChecked == true ? onRegister : null,
                  buttonText: 'SIGN IN',
                  v: 15.h,
                  h: 110.w,
                ),
              ],
            ),
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
