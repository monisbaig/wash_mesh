// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/providers/user_provider/user_auth_provider.dart';
import 'package:wash_mesh/user_screens/user_settings.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_text_field.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_logo.dart';
import '../widgets/custom_navigation_bar.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final formKey = GlobalKey<FormState>();
  File? profileImg;
  dynamic convertedImage;
  dynamic getImage;
  bool loading = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();

  getUserData() async {
    setState(() {
      loading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('userToken');
    final url = Uri.parse(
        'https://washmesh.stackbuffers.com/api/user/customer/profile');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      var firstN = json['data']['User']['first_name'];
      var lastN = json['data']['User']['last_name'];
      var add = json['data']['User']['address'];
      var img = json['data']['User']['image'];

      setState(() {
        firstName.text = firstN;
        lastName.text = lastN;
        address.text = add;
        loading = false;
        getImage = img;
      });
    }
  }

  onUpdateUser() async {
    final userData = Provider.of<UserAuthProvider>(context, listen: false);
    try {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        final result = await userData.updateUserData(
          firstName: firstName.text,
          lastName: lastName.text,
          address: address.text,
        );
        firstName.clear();
        lastName.clear();
        address.clear();

        await onUpdateImage();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result'),
          ),
        );

        if (result != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const CustomNavigationBar(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const UserSettings(),
            ),
          );
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  onUpdateImage() async {
    final userData = Provider.of<UserAuthProvider>(context, listen: false);
    try {
      final result = await userData.updateUserImage(
        image: convertedImage,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$result'),
        ),
      );

      if (result != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const CustomNavigationBar(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const UserSettings(),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

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

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 12.w),
            child: Column(
              children: [
                const CustomLogo(),
                SizedBox(height: 15.h),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 30.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: profileImage,
                      child: loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ClipOval(
                              child: profileImg != null
                                  ? Image.file(
                                      profileImg!,
                                      width: 105.w,
                                      height: 100.h,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      '$getImage',
                                      width: 105.w,
                                      height: 100.h,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                    ),
                  ],
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
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  onTextPress: onUpdateUser,
                  buttonText: 'Save Changes',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
