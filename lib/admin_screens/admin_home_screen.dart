import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
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
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      var firstN = json['data']['Vendor']['first_name'];
      var availability =
          json['data']['Vendor']['vendor_details']['availability'];

      setState(() {
        firstName = firstN;
        available = availability;
      });
    }
  }

  dynamic firstName;
  bool isOn = false;
  dynamic available;

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
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 27.h, horizontal: 10.w),
                        child: Column(
                          children: [
                            const CustomLogo(),
                            SizedBox(height: 8.h),
                            Text(
                              'Dashboard',
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
                                      isOn
                                          ? 'available'.tr()
                                          : 'notAvailable'.tr(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 100.w),
                                    Switch(
                                      activeColor: Colors.white,
                                      activeTrackColor: Colors.greenAccent,
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
                                      'commission'.tr(),
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
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              locationData.items.last.location!
                                                  .address!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
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
                              },
                            ),
                            SizedBox(height: 8.h),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddPlaceScreen(),
                                  ),
                                );
                              },
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
                                      'location'.tr(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 60.w),
                                    Icon(
                                      Icons.save,
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
                                  'editService'.tr(),
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
                                  'quickTab'.tr(),
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
                                        'total'.tr(),
                                        style: TextStyle(
                                          color: CustomColor().mainColor,
                                        ),
                                      ),
                                      Text(
                                        'earning'.tr(),
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
                                        'total'.tr(),
                                        style: TextStyle(
                                          color: CustomColor().mainColor,
                                        ),
                                      ),
                                      Text(
                                        'booking'.tr(),
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
                                        'upcoming'.tr(),
                                        style: TextStyle(
                                          color: CustomColor().mainColor,
                                        ),
                                      ),
                                      Text(
                                        'service'.tr(),
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
                                        "today".tr(),
                                        style: TextStyle(
                                          color: CustomColor().mainColor,
                                        ),
                                      ),
                                      Text(
                                        'service'.tr(),
                                        style: TextStyle(
                                          color: CustomColor().mainColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
