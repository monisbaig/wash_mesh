import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/admin_screens/add_place_screen.dart';
import 'package:wash_mesh/admin_screens/today_services.dart';
import 'package:wash_mesh/admin_screens/total_bookings.dart';
import 'package:wash_mesh/admin_screens/total_earnings.dart';
import 'package:wash_mesh/admin_screens/upcoming_services.dart';
import 'package:wash_mesh/providers/admin_provider/admin_auth_provider.dart';
import 'package:wash_mesh/widgets/custom_background.dart';

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
  void initState() {
    super.initState();
    getAdminData();
  }

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
      var json = jsonDecode(response.body);
      var firstN = json['data']['Vendor']['first_name'];
      var availability =
          json['data']['Vendor']['vendor_details']['availability'];

      setState(() {
        firstName = firstN;
        availability = availability;
      });
    }
  }

  dynamic firstName;
  dynamic availability;

  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      op: 0.1,
      ch: FutureBuilder(
          future: Provider.of<AdminAuthProvider>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
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
                                    'Hello, $firstName',
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
                                    DateTime.now().year.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.sp,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  Text(
                                    DateTime.now().hour.toString(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    isOn ? 'Available' : 'Not Available',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 100.w),
                                  Switch(
                                    value: isOn,
                                    onChanged: (value) {
                                      setState(() {
                                        isOn = value;
                                      });
                                    },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                          Consumer<AdminAuthProvider>(
                              builder: (context, locationData, _) {
                            return Container(
                              width: double.infinity,
                              height: 54.h,
                              decoration: BoxDecoration(
                                color: CustomColor().mainColor,
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, index) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      locationData.items.last.location!.address!
                                          .substring(23),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 100.w),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AddPlaceScreen(),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.my_location,
                                        size: 28.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
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
                                      builder: (context) =>
                                          const AdminServices(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/group.png',
                                  fit: BoxFit.cover,
                                  height: 100.h,
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
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TotalEarningsScreen(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80.w,
                                      height: 87.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(45.r),
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
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TotalBookingScreen(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80.w,
                                      height: 87.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(45.r),
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
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpcomingServiceScreen(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80.w,
                                      height: 87.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(45.r),
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
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TodayServicesScreen(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80.w,
                                      height: 87.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(45.r),
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
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
