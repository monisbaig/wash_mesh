import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/admin_screens/admin_update_services.dart';
import 'package:wash_mesh/admin_screens/today_services.dart';
import 'package:wash_mesh/admin_screens/total_bookings.dart';
import 'package:wash_mesh/admin_screens/total_earnings.dart';
import 'package:wash_mesh/admin_screens/upcoming_services.dart';
import 'package:wash_mesh/widgets/custom_background.dart';

import '../models/admin_models/admin_model.dart';
import '../providers/admin_provider/admin_auth_provider.dart';
import '../widgets/custom_colors.dart';
import '../widgets/custom_logo.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var adminData = Provider.of<AdminAuthProvider>(context, listen: false);

    return CustomBackground(
      op: 0.1,
      ch: SafeArea(
        child: FutureBuilder<AdminModel>(
          future: adminData.getAdminData(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    heightFactor: 20.h,
                    child: const CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
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
                                    '${'hello'.tr()}, ${snapshot.data!.data!.vendor!.userName}',
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
                          SizedBox(height: 15.h),
                          InkWell(
                            onTap: () async {
                              var availability = snapshot.data!.data!.vendor!
                                  .vendorDetails!.availability;

                              await adminData.updateAvailability(
                                  availability: availability, context: context);
                              setState(() {});
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
                                    snapshot.data!.data!.vendor!.vendorDetails!
                                                .availability ==
                                            '1'
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
                                    value: snapshot.data!.data!.vendor!
                                                .vendorDetails!.availability ==
                                            '1'
                                        ? true
                                        : false,
                                    onChanged: (bool value) {},
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
                                          const AdminUpdateServices(),
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
                  );
          },
        ),
      ),
    );
  }
}
