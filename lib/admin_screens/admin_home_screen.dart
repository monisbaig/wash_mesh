// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/admin_screens/admin_update_services.dart';
import 'package:wash_mesh/admin_screens/today_services.dart';
import 'package:wash_mesh/admin_screens/total_bookings.dart';
import 'package:wash_mesh/admin_screens/total_earnings.dart';
import 'package:wash_mesh/admin_screens/upcoming_services.dart';
import 'package:wash_mesh/global_variables/global_variables.dart';
import 'package:wash_mesh/widgets/custom_background.dart';

import '../admin_assistant/admin_assistant_methods.dart';
import '../models/admin_models/admin_model.dart';
import '../providers/admin_provider/admin_auth_provider.dart';
import '../providers/admin_provider/admin_info_provider.dart';
import '../widgets/custom_colors.dart';
import '../widgets/custom_logo.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final Completer<GoogleMapController> _googleMapController =
      Completer<GoogleMapController>();

  GoogleMapController? newGoogleMapController;

  Position? userCurrentPosition;
  LocationPermission? _locationPermission;
  bool isLoading = false;

  void mapDarkTheme() {
    newGoogleMapController!.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
  }

  allowLocationPermission() async {
    _locationPermission = await Geolocator.requestPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  userLocation() async {
    setState(() {
      isLoading = true;
    });
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    userCurrentPosition = currentPosition;

    LatLng latLngPosition =
        LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);

    CameraPosition cameraPosition = CameraPosition(
      target: latLngPosition,
      zoom: 14,
    );

    newGoogleMapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        cameraPosition,
      ),
    );

    await AdminAssistantMethods.reverseGeocoding(userCurrentPosition!, context);
    setState(() {
      isLoading = false;
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    allowLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    var adminData = Provider.of<AdminAuthProvider>(context, listen: false);
    var locationData = Provider.of<AdminInfoProvider>(context, listen: false)
        .adminPickUpLocation;

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
                                    '${'hello'.tr()}, ${snapshot.data!.data!.vendor!.userName.toString().toCapitalized()}',
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
                          Container(
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
                                  onChanged: (bool value) async {
                                    var availability = snapshot.data!.data!
                                        .vendor!.vendorDetails!.availability;

                                    await adminData.updateAvailability(
                                      availability: availability,
                                      context: context,
                                    );
                                    setState(() {});
                                  },
                                ),
                              ],
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
                          SizedBox(
                            height: 200.h,
                            child: GoogleMap(
                              mapType: MapType.normal,
                              myLocationEnabled: true,
                              zoomGesturesEnabled: false,
                              zoomControlsEnabled: false,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (controller) {
                                _googleMapController.complete(controller);
                                newGoogleMapController = controller;

                                userLocation();
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 50.h,
                            color: CustomColor().mainColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10.w),
                                Flexible(
                                  child: isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          overflow: TextOverflow.ellipsis,
                                          locationData != null
                                              ? locationData.locationName!
                                              : 'Current Location',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                ),
                                SizedBox(width: 10.w),
                              ],
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
