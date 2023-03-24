// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/providers/user_provider/user_info_provider.dart';

import '../../widgets/custom_navigation_bar.dart';
import '../../widgets/progress_dialog.dart';
import '../assistants/user_assistant_methods.dart';
import '../assistants/user_geofire_assistant.dart';
import '../models/active_drivers_model.dart';
import '../user_global_variables/user_global_variables.dart';
import 'active_drivers_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _googleMapController =
      Completer<GoogleMapController>();
  GoogleMapController? newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double searchLocationHeight = 300;
  double mapBottomPadding = 0;
  bool openNavigationDrawer = true;

  Position? userCurrentPosition;
  LocationPermission? _locationPermission;

  allowLocationPermission() async {
    _locationPermission = await Geolocator.requestPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  userLocation() async {
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

    await UserAssistantMethods.reverseGeocoding(userCurrentPosition!, context);

    initializeGeoFire();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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

  @override
  void initState() {
    super.initState();
    allowLocationPermission();
  }

  List<LatLng> polyLineCoordinatesList = [];
  Set<Polyline> polyLineSet = {};

  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};

  Future<void> drawPolyLines() async {
    var originData = Provider.of<UserInfoProvider>(context, listen: false)
        .userPickUpLocation;
    var destinationData = Provider.of<UserInfoProvider>(context, listen: false)
        .userDropOffLocation;

    var originDirection =
        LatLng(originData!.locationLatitude!, originData.locationLongitude!);
    var destinationDirection = LatLng(
        destinationData!.locationLatitude!, destinationData.locationLongitude!);

    showDialog(
      context: context,
      builder: (context) {
        return const ProgressDialog(
          message: 'Please wait...',
        );
      },
    );

    var directionDetails = await UserAssistantMethods.getDirectionDetail(
        originDirection, destinationDirection);

    setState(() {
      tripDirectionDetails = directionDetails;
    });

    Navigator.pop(context);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLineList =
        polylinePoints.decodePolyline(directionDetails!.points!);

    polyLineCoordinatesList.clear();

    if (decodedPolyLineList.isNotEmpty) {
      for (PointLatLng pointLatLng in decodedPolyLineList) {
        polyLineCoordinatesList
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      }
    }
    polyLineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        polylineId: const PolylineId('polyLineId'),
        points: polyLineCoordinatesList,
        color: Colors.blue,
        width: 2,
        jointType: JointType.round,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );
      polyLineSet.add(polyline);
    });

    LatLngBounds latLngBounds;

    if (originDirection.latitude > destinationDirection.latitude &&
        originDirection.longitude > destinationDirection.longitude) {
      latLngBounds = LatLngBounds(
        southwest: destinationDirection,
        northeast: originDirection,
      );
    } else if (originDirection.longitude > destinationDirection.longitude) {
      latLngBounds = LatLngBounds(
        southwest: LatLng(
          originDirection.latitude,
          destinationDirection.longitude,
        ),
        northeast: LatLng(
          destinationDirection.latitude,
          originDirection.longitude,
        ),
      );
    } else if (originDirection.latitude > destinationDirection.latitude) {
      latLngBounds = LatLngBounds(
        southwest: LatLng(
          destinationDirection.latitude,
          originDirection.longitude,
        ),
        northeast: LatLng(
          originDirection.latitude,
          destinationDirection.longitude,
        ),
      );
    } else {
      latLngBounds = LatLngBounds(
        southwest: originDirection,
        northeast: destinationDirection,
      );
    }

    newGoogleMapController!.animateCamera(
      CameraUpdate.newLatLngBounds(latLngBounds, 65),
    );

    Marker originMarker = Marker(
      markerId: const MarkerId('originId'),
      infoWindow: InfoWindow(title: originData.locationName, snippet: 'Origin'),
      position: originDirection,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    Marker destinationMarker = Marker(
      markerId: const MarkerId('destinationId'),
      infoWindow: InfoWindow(
          title: destinationData.locationName, snippet: 'Destination'),
      position: destinationDirection,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    setState(() {
      markerSet.add(originMarker);
      markerSet.add(destinationMarker);
    });

    Circle originCircle = Circle(
      circleId: const CircleId('originId'),
      fillColor: Colors.green,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: originDirection,
    );
    Circle destinationCircle = Circle(
      circleId: const CircleId('destinationId'),
      fillColor: Colors.green,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: destinationDirection,
    );

    setState(() {
      circleSet.add(originCircle);
      circleSet.add(destinationCircle);
    });
  }

  bool activeDriversNearby = false;

  initializeGeoFire() {
    Geofire.initialize('activeDrivers');

    Geofire.queryAtLocation(
            userCurrentPosition!.latitude, userCurrentPosition!.longitude, 10)!
        .listen((map) {
      if (map != null) {
        var callBack = map['callBack'];

        switch (callBack) {
          case Geofire.onKeyEntered:
            ActiveDriversModel activeDriversModel = ActiveDriversModel();

            activeDriversModel.driverId = map['key'];
            activeDriversModel.driverLatitude = map['latitude'];
            activeDriversModel.driverLongitude = map['longitude'];

            UserGeoFireAssistant.activeDriversList.add(activeDriversModel);

            if (activeDriversNearby == true) {
              activeDriversPosition();
            }

            break;

          case Geofire.onKeyExited:
            UserGeoFireAssistant.removeActiveDriver(map['key']);
            activeDriversPosition();

            break;

          case Geofire.onKeyMoved:
            ActiveDriversModel activeDriversModel = ActiveDriversModel();

            activeDriversModel.driverId = map['key'];
            activeDriversModel.driverLatitude = map['latitude'];
            activeDriversModel.driverLongitude = map['longitude'];

            UserGeoFireAssistant.updateActiveDriver(activeDriversModel);
            activeDriversPosition();

            break;

          case Geofire.onGeoQueryReady:
            activeDriversNearby = true;
            activeDriversPosition();

            break;
        }
      }

      setState(() {});
    });
  }

  BitmapDescriptor? activeDriverCustomMarker;

  void activeDriversCustomMarker() async {
    if (activeDriverCustomMarker == null) {
      ImageConfiguration imageConfiguration =
          const ImageConfiguration(size: Size(2, 2));

      var newMarker = await BitmapDescriptor.fromAssetImage(
          imageConfiguration, 'assets/images/car.png');

      activeDriverCustomMarker = newMarker;
    }
  }

  void activeDriversPosition() {
    setState(() {
      markerSet.clear();
      circleSet.clear();

      Set<Marker> driversMarker = {};

      for (ActiveDriversModel activeDrivers
          in UserGeoFireAssistant.activeDriversList) {
        LatLng latLng = LatLng(
            activeDrivers.driverLatitude!, activeDrivers.driverLongitude!);

        Marker marker = Marker(
          markerId: MarkerId('driver ${activeDrivers.driverId!}'),
          position: latLng,
          icon: activeDriverCustomMarker!,
          rotation: 360,
        );

        driversMarker.add(marker);
      }
      setState(() {
        markerSet = driversMarker;
      });
    });
  }

  DatabaseReference? rideRef;

  void saveRideRequest() {
    rideRef =
        FirebaseDatabase.instance.ref().child('All Order Requests').push();

    var originLocation = Provider.of<UserInfoProvider>(context, listen: false)
        .userPickUpLocation;

    Map originLocationMap = {
      'latitude': originLocation!.locationLatitude,
      'longitude': originLocation.locationLongitude,
    };

    Map userInfoMap = {
      'origin': originLocationMap,
      'time': DateTime.now().toString(),
      'userName': userModel!.name,
      'userPhone': userModel!.phone,
      'originAddress': originLocation.locationName,
      'driverId': 'waiting',
    };

    rideRef!.set(userInfoMap);

    activeNearestDriversList();
  }

  void activeNearestDriversList() async {
    List availableDriversList = UserGeoFireAssistant.activeDriversList;

    if (availableDriversList.isEmpty) {
      rideRef!.remove();

      setState(() {
        polyLineSet.clear();
        markerSet.clear();
        circleSet.clear();
        polyLineCoordinatesList.clear();
      });

      Fluttertoast.showToast(
        msg: 'No drivers currently available, Please try again after sometime',
      );

      return;
    }

    await retrieveActiveDriversInfo(availableDriversList);

    var response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ActiveDriversScreen(rideRef: rideRef),
      ),
    );

    if (response == 'selectedDriver') {
      FirebaseDatabase.instance
          .ref()
          .child('vendor')
          .child(selectedDriverId!)
          .once()
          .then((snapshot) {
        if (snapshot.snapshot.value != null) {
          sendNotificationToDriver(selectedDriverId!);
        } else {
          Fluttertoast.showToast(msg: 'This Driver not exist.');
        }
      });
    }
  }

  sendNotificationToDriver(String selectedDriverId) {
    FirebaseDatabase.instance
        .ref()
        .child('vendor')
        .child(selectedDriverId)
        .child('vendorStatus')
        .set(rideRef!.key);

    FirebaseDatabase.instance
        .ref()
        .child('vendor')
        .child(selectedDriverId)
        .child('fcmToken')
        .once()
        .then((token) {
      if (token.snapshot.value != null) {
        String fcmToken = token.snapshot.value.toString();

        UserAssistantMethods.sendNotificationToDriver(
          fcmToken,
          rideRef!.key.toString(),
        );

        Fluttertoast.showToast(msg: 'Notification sent Successfully');
      } else {
        Fluttertoast.showToast(msg: 'Please choose another driver');
        return;
      }
    });
  }

  retrieveActiveDriversInfo(List availableDriversList) async {
    for (int i = 0; i < availableDriversList.length; i++) {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child('vendor');
      await ref
          .child(availableDriversList[i].driverId.toString())
          .once()
          .then((dataSnapshot) {
        var driverKeyInfo = dataSnapshot.snapshot.value;

        activeDriversList!.add(driverKeyInfo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var locationData = Provider.of<UserInfoProvider>(context, listen: false)
        .userPickUpLocation;

    activeDriversCustomMarker();

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapBottomPadding, top: 20),
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: polyLineSet,
            markers: markerSet,
            circles: circleSet,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (controller) {
              _googleMapController.complete(controller);
              newGoogleMapController = controller;

              //for Dark Theme
              mapDarkTheme();
              userLocation();
              setState(() {
                mapBottomPadding = 320;
              });
            },
          ),
          Positioned(
            top: 36,
            left: 22,
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomNavigationBar(),
                  ),
                  (route) => false,
                );
              },
              child: const CircleAvatar(
                child: Icon(
                  Icons.home_filled,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSize(
              curve: Curves.easeIn,
              duration: const Duration(microseconds: 120),
              child: Container(
                height: searchLocationHeight,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.add_location_alt_outlined,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'From',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                locationData != null
                                    ? '${locationData.locationName!.substring(0, 29)}...'
                                    : 'Pick Up Location',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (locationData == null) {
                            Fluttertoast.showToast(
                                msg: 'Please select your location first');
                          } else {
                            saveRideRequest();
                          }
                        },
                        child: const Text('Send your location to Vendor'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}