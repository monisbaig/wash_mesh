import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
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
  dynamic selectedGender;
  List gender = [
    'Male',
    'Female',
  ];

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
      Navigator.of(context).pop();
    });
  }

  experienceCertCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 300,
    );

    if (imageFile == null) {
      return;
    }
    expCert = File(imageFile.path);
    final imageByte = expCert!.readAsBytesSync();
    setState(() {
      base64ImageExp = "data:image/png;base64,${base64Encode(imageByte)}";
      Navigator.of(context).pop();
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
      Navigator.of(context).pop();
    });
  }

  cnicFrontImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 300,
    );

    if (imageFile == null) {
      return;
    }
    cnicFront = File(imageFile.path);
    final imageByte = cnicFront!.readAsBytesSync();
    setState(() {
      base64ImageF = "data:image/png;base64,${base64Encode(imageByte)}";
      Navigator.of(context).pop();
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
      Navigator.of(context).pop();
    });
  }

  cnicBackImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 300,
    );
    if (imageFile == null) {
      return;
    }
    cnicBack = File(imageFile.path);
    final imageByte = cnicBack!.readAsBytesSync();
    setState(() {
      base64ImageB = "data:image/png;base64,${base64Encode(imageByte)}";
      Navigator.of(context).pop();
    });
  }

  File? profileImg;
  dynamic convertedImage;

  profileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
    );
    if (imageFile == null) {
      return;
    }
    profileImg = File(imageFile.path);

    final imageByte = profileImg!.readAsBytesSync();
    setState(() {
      convertedImage = "data:image/png;base64,${base64Encode(imageByte)}";
    });
  }

  onRegister() async {
    final adminData = Provider.of<AdminAuthProvider>(context, listen: false);
    try {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        VendorDetails vendorDetails = VendorDetails(
          gender: gender.indexOf(selectedGender).toString(),
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

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const AdminLoginForm(),
          ),
        );
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
                    'Registration Form',
                    style: TextStyle(
                      fontSize: 25.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: profileImage,
                  child: ClipOval(
                    child: profileImg != null
                        ? Image.file(
                            profileImg!,
                            width: 105.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/profile.png',
                            width: 105.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(height: 15.h),
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
                        hint: 'userName'.tr(),
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
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
                        hint: 'phoneNo'.tr(),
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
                        controller: phoneNo,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your valid number starting from 92';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'cnicNo'.tr(),
                        controller: cnicNo,
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 13) {
                            return 'Please enter your cnic number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'password'.tr(),
                        controller: password,
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
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
                        controller: confirmPassword,
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
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
                        hint: 'experience'.tr(),
                        controller: experience,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'referralCode'.tr(),
                        controller: code,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        hint: 'address'.tr(),
                        controller: address,
                        suffixIcon: const Icon(
                          Icons.star,
                          size: 20,
                        ),
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
                        builder: (context) => const AdminLoginForm(),
                      ),
                    );
                  },
                  child: Text(
                    'alreadyAccount'.tr(),
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Choose an Option:'),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          ElevatedButton(
                            onPressed: experienceCert,
                            child: const Text('Gallery'),
                          ),
                          ElevatedButton(
                            onPressed: experienceCertCamera,
                            child: const Text('Camera'),
                          ),
                        ],
                      );
                    },
                  ),
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
                        Text(
                          'experienceCert'.tr(),
                          style: const TextStyle(
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
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            title: const Text('Choose an Option:'),
                            actions: [
                              ElevatedButton(
                                onPressed: cnicFrontImage,
                                child: const Text('Gallery'),
                              ),
                              ElevatedButton(
                                onPressed: cnicFrontImageCamera,
                                child: const Text('Camera'),
                              ),
                            ],
                          );
                        },
                      ),
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
                            Text(
                              'cnicFront'.tr(),
                              style: const TextStyle(
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
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            title: const Text('Choose an Option:'),
                            actions: [
                              ElevatedButton(
                                onPressed: cnicBackImage,
                                child: const Text('Gallery'),
                              ),
                              ElevatedButton(
                                onPressed: cnicBackImageCamera,
                                child: const Text('Camera'),
                              ),
                            ],
                          );
                        },
                      ),
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
                            Text(
                              'cnicBack'.tr(),
                              style: const TextStyle(
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
                SizedBox(height: 20.h),
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
