import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/admin_screens/admin_settings.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar_admin.dart';
import 'package:wash_mesh/widgets/custom_text_field.dart';

import '../providers/admin_provider/admin_auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_logo.dart';
import 'admin_home_screen.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final formKey = GlobalKey<FormState>();
  String? image;
  File? profileImg;
  File? convertedImage;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();

  getAdminData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final url =
        Uri.parse('https://washmesh.stackbuffers.com/api/user/vendor/profile');
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
      var firstN = json['data']['Vendor']['first_name'];
      var lastN = json['data']['Vendor']['last_name'];
      var add = json['data']['Vendor']['address'];
      var img = json['data']['Vendor']['image'];

      setState(() {
        firstName.text = firstN;
        lastName.text = lastN;
        address.text = add;
        image = img;
      });
    }
  }

  onUpdateAdmin() async {
    final adminData = Provider.of<AdminAuthProvider>(context, listen: false);
    try {
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        final result = await adminData.updateAdminData(
          firstName: firstName.text,
          lastName: lastName.text,
          address: address.text,
        );
        firstName.clear();
        lastName.clear();
        address.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result'),
          ),
        );

        if (result != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AdminHomeScreen(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AdminSettings(),
            ),
          );
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  onUpdateImage() async {
    final adminData = Provider.of<AdminAuthProvider>(context, listen: false);
    try {
      final result = await adminData.updateAdminImage(
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
            builder: (context) => const AdminHomeScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const AdminSettings(),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  profileImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 200,
    );
    profileImg = File(image!.path);
    final imageByte = profileImg!.readAsBytesSync();
    setState(() {
      convertedImage = base64Encode(imageByte) as File?;
    });
  }

  @override
  void initState() {
    super.initState();
    getAdminData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomNavigationBarAdmin(
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
                  'Vendor Profile',
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
                    child: ClipOval(
                      child: profileImg != null
                          ? Image.file(
                              profileImg!,
                              width: 102.w,
                              height: 108.h,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              '$image',
                              width: 102.w,
                              height: 108.h,
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
                onTextPress: onUpdateAdmin,
                buttonText: 'Save Changes',
                v: 15.h,
                h: 90.w,
              ),
              CustomButton(
                onTextPress: onUpdateImage,
                buttonText: 'Image',
                v: 15.h,
                h: 90.w,
              ),
              SizedBox(height: 33.h),
            ],
          ),
        ),
      ),
    );
  }
}
