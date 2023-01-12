import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/user_screens/wash_category_screen.dart';
import 'package:wash_mesh/widgets/custom_colors.dart';
import 'package:wash_mesh/widgets/custom_logo.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar.dart';

import 'mesh_category_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(
      ch: SafeArea(
        child: SingleChildScrollView(
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
                        'Hello, Ahmed',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 26.sp,
                        ),
                      ),
                      Text(
                        'Welcome back!',
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
                        '12/14/2022',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Text(
                        '12:05 PM',
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
                        'Location',
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
                    'Categories',
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
                    'Frequently Used',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 30.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/car-wash.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h),
                      const Text('Car Wash'),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/car-wash.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h),
                      const Text('Car Wash'),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/car-wash.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h),
                      const Text('Car Wash'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/mechanic.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h),
                      const Text('Mechanic'),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/mechanic.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h),
                      const Text('Mechanic'),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/mechanic.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h),
                      const Text('Mechanic'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
      op: 0.1,
    );
  }
}
