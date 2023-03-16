import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/user_screens/wash_book_screen.dart';
import 'package:wash_mesh/user_screens/wash_category_screen.dart';
import 'package:wash_mesh/widgets/custom_background.dart';
import 'package:wash_mesh/widgets/custom_colors.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';

import '../models/user_models/mesh_categories_model.dart' as mc;
import '../models/user_models/user_model.dart';
import '../models/user_models/wash_categories_model.dart' as um;
import '../providers/user_provider/user_auth_provider.dart';
import 'mesh_book_screen.dart';
import 'mesh_category_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  User user = User();

  dynamic token;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
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
      setState(() {
        firstName = firstN;
      });
    }
  }

  dynamic firstName;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      ch: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 27.h, horizontal: 10.w),
            child: Column(
              children: [
                const CustomLogo(),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${'hello'.tr()}, $firstName',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 26.sp,
                          ),
                        ),
                        Text(
                          'welcome'.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateTime.now().toString().substring(0, 11),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          DateTime.now().toString().substring(11, 16),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Image.asset(
                  'assets/images/home-cover.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: CustomColor().mainColor,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor().shadowColor2,
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'location'.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 100.w),
                        Icon(
                          Icons.my_location,
                          size: 28.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      'category'.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const WashCategory(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/wash.png',
                        width: 140.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MeshCategory(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/mesh.png',
                        width: 140.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'used'.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                FutureBuilder<um.WashCategoryModel>(
                  future: UserAuthProvider.getWashCategories(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  List<um.Data> data = snapshot.data!.data!;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => WashBookScreen(
                                        data,
                                        snapshot.data!.data!
                                            .elementAt(index)
                                            .name,
                                        snapshot.data!.data!
                                            .elementAt(index)
                                            .id,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Image.network(
                                      snapshot.data!.data!
                                          .elementAt(index)
                                          .image,
                                      fit: BoxFit.contain,
                                      width: 80.w,
                                      height: 80.h,
                                    ),
                                    SizedBox(height: 10.h),
                                    Flexible(
                                      child: Text(
                                        "${snapshot.data!.data!.elementAt(index).name}",
                                        // overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                  },
                ),
                SizedBox(height: 10.h),
                FutureBuilder<mc.MeshCategoryModel>(
                  future: UserAuthProvider.getMeshCategories(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  List<mc.Data> data = snapshot.data!.data!;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MeshBookScreen(
                                        data,
                                        snapshot.data!.data!
                                            .elementAt(index)
                                            .name,
                                        snapshot.data!.data!
                                            .elementAt(index)
                                            .id,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Image.network(
                                      snapshot.data!.data!
                                          .elementAt(index)
                                          .image,
                                      fit: BoxFit.contain,
                                      width: 80.w,
                                      height: 80.h,
                                    ),
                                    SizedBox(height: 10.h),
                                    Flexible(
                                      child: Text(
                                        "${snapshot.data!.data!.elementAt(index).name}",
                                        // overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                  },
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
