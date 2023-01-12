import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wash_mesh/widgets/custom_navigation_bar_admin.dart';

import '../widgets/custom_colors.dart';
import '../widgets/custom_logo.dart';
import 'admin_services.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomNavigationBarAdmin(
      ch: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomLogo(),
              SizedBox(height: 8.h),
              Text(
                'Service Provider Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25.sp,
                ),
              ),
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
              SizedBox(height: 15.h),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: CustomColor().mainColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Available Status',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 100.w),
                      Icon(
                        Icons.toggle_on,
                        size: 35.sp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: CustomColor().mainColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'My Commission : Rs 5',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 60.w),
                      Icon(
                        Icons.percent_rounded,
                        size: 28.sp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: CustomColor().mainColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Change Location',
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
                    'Edit Services',
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
                          builder: (context) => const AdminServices(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/group.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Text(
                    'Quick Tabs',
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
                      Container(
                        width: 80.w,
                        height: 87.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45.r),
                        ),
                        child: Icon(
                          Icons.camera,
                          size: 50,
                          color: CustomColor().mainColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Total',
                        style: TextStyle(
                          color: CustomColor().mainColor,
                        ),
                      ),
                      Text(
                        'Earnings',
                        style: TextStyle(
                          color: CustomColor().mainColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 80.w,
                        height: 87.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45.r),
                        ),
                        child: Icon(
                          Icons.edit_calendar_outlined,
                          size: 50,
                          color: CustomColor().mainColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Total',
                        style: TextStyle(
                          color: CustomColor().mainColor,
                        ),
                      ),
                      Text(
                        'Bookings',
                        style: TextStyle(
                          color: CustomColor().mainColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 80.w,
                        height: 87.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45.r),
                        ),
                        child: Icon(
                          Icons.list_alt_outlined,
                          size: 50,
                          color: CustomColor().mainColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Upcoming',
                        style: TextStyle(
                          color: CustomColor().mainColor,
                        ),
                      ),
                      Text(
                        'Services',
                        style: TextStyle(
                          color: CustomColor().mainColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 80.w,
                        height: 87.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45.r),
                        ),
                        child: Icon(
                          Icons.design_services_outlined,
                          size: 50,
                          color: CustomColor().mainColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Today's",
                        style: TextStyle(
                          color: CustomColor().mainColor,
                        ),
                      ),
                      Text(
                        'Services',
                        style: TextStyle(
                          color: CustomColor().mainColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      op: 0.1,
    );
  }
}
