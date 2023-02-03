import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/providers/admin_provider/place_model.dart';

import '../../helpers/dp_helper.dart';
import '../../helpers/location_helper.dart';
import '../../models/admin_models/admin_registration_model.dart';

class AdminAuthProvider extends ChangeNotifier {
  static const baseURL = 'https://washmesh.stackbuffers.com/api';

// Admin Authentication Code:

  Future<Vendor> getAdminProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final url = Uri.parse('$baseURL/user/vendor/profile');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    }
    notifyListeners();
    return jsonDecode(response.body);
  }

  Future<Vendor> registerAdmin(Vendor adminData) async {
    final url = Uri.parse('$baseURL/user/vendor/register');

    final response = await http.post(
      url,
      body: jsonEncode(<String, dynamic>{
        'first_name': adminData.firstName,
        'last_name': adminData.lastName,
        'phone': adminData.phone,
        'address': adminData.address,
        'password': adminData.password,
        'confirm_password': adminData.confirmPassword,
        'user_name': adminData.userName,
        'referral_code': adminData.referralCode,
        'cnic': adminData.vendorDetails!.cnic,
        'experience': adminData.vendorDetails!.experience,
        'gender': adminData.vendorDetails!.gender,
        'experience_cert_img': adminData.vendorDetails!.experienceCertImg,
        'cnic_front_img': adminData.vendorDetails!.cnicFrontImg,
        'cnic_back_img': adminData.vendorDetails!.cnicBackImg,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    try {
      if (response.statusCode == 200) {
        print(Vendor.fromJson(jsonDecode(response.body)));
        return Vendor.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(Vendor.fromJson(jsonDecode(response.body)));
      rethrow;
    }
    print(Vendor.fromJson(jsonDecode(response.body)));
    notifyListeners();
    return Vendor.fromJson(jsonDecode(response.body));
  }

  loginAdmin({
    var input,
    var password,
  }) async {
    final url =
        Uri.parse('$baseURL/user/vendor/login?input=$input&password=$password');
    final response = await http.post(url);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['message'] ==
          'Vendor Login Successfully!') {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('Vendor', response.body);
        pref.setString('token', jsonDecode(response.body)['data']['token']);
        print(jsonDecode(response.body)['data']['token']);
      }
      return jsonDecode(response.body)['message'];
    } else {
      print(response.body);
    }
    notifyListeners();
  }

  updateAdminPassword({var newPassword}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    var url = Uri.parse('$baseURL/user/update/password?password=$newPassword');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    notifyListeners();
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      return 'Registration Failed';
    }
  }

  updateAdminData(
      {var firstName, var lastName, var address, String? image}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    var jsonObject = {
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
    };
    var jsonString = jsonEncode(jsonObject);

    var url = Uri.parse('$baseURL/user/vendor/update/profile');
    var response = await http.post(
      url,
      body: jsonString,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    notifyListeners();
  }

  updateAdminImage({dynamic image}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    var jsonObject = {
      'image': image,
    };
    var jsonString = jsonEncode(jsonObject);

    var url = Uri.parse('$baseURL/user/vendor/update/image');
    var response = await http.post(
      url,
      body: jsonString,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    notifyListeners();
  }

  List<PlaceModel> _items = [];

  List<PlaceModel> get items {
    return [..._items];
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => PlaceModel(
              id: item['id'],
              location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }

  Future<void> addPlace(
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude!, pickedLocation.longitude!);
    final updateLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = PlaceModel(
      id: DateTime.now().toString(),
      location: updateLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address,
    });
  }
}
