import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/models/customer_registration_model.dart';

class AuthProvider extends ChangeNotifier {
  static const baseURL = 'https://washmesh.stackbuffers.com/api';

  // User Authentication Code:

  Future<CustomerRegistrationModel> registerCustomer(
      CustomerRegistrationModel data) async {
    final url = Uri.parse('$baseURL/user/customer/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data.toJson()),
    );
    try {
      if (response.statusCode == 201) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('UserData', response.body);
        pref.setString('token', data.data!.token.toString());

        return CustomerRegistrationModel.fromJson(jsonDecode(response.body));
      }
      notifyListeners();
      return CustomerRegistrationModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  loginUser({
    var input,
    var password,
  }) async {
    final url =
        Uri.parse('$baseURL/user/custom/login?input=$input&password=$password');
    final response = await http.post(url);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['message'] == 'Login Successfully') {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('User', response.body);
        pref.setString('token', jsonDecode(response.body)['data']['token']);
      }
      return jsonDecode(response.body)['message'];
    } else {
      print(response.body);
    }
    notifyListeners();
  }

  updateUserData({var firstName, var lastName, var address}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    var jsonObject = {
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
    };
    var jsonString = jsonEncode(jsonObject);

    var url = Uri.parse('$baseURL/user/customer/update/profile');
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

  updateUserPassword({var newPassword}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    var url =
        Uri.parse('$baseURL/vendor/update/password?password=$newPassword');
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

  recreateUserPassword({var input, var newPassword}) async {
    var url = Uri.parse(
        '$baseURL/user/forget/password?input=$input&password=$newPassword');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ',
      },
    );
    notifyListeners();
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      return 'Registration Failed';
    }
  }

// Admin Authentication Code:

  Future<String> registerAdmin({
    var firstName,
    var lastName,
    var userName,
    var phoneNo,
    var cnicNo,
    var password,
    var confirmPassword,
    var experience,
    var code,
    var address,
    var gender,
    var vendor,
    var experienceCert,
    var cnicFront,
    var cnicBack,
  }) async {
    var jsonObject = {
      'first_name': firstName,
      'last_name': lastName,
      'user_name': userName,
      'phone': phoneNo,
      'cnic': cnicNo,
      'password': password,
      'confirm_password': confirmPassword,
      'experience': experience,
      'referral_code': code,
      'address': address,
      'gender': gender,
      'experience_cert_img': experienceCert,
      'cnic_front_img': cnicFront,
      'cnic_back_img': cnicBack,
    };

    var jsonString = jsonEncode(jsonObject);

    var url = Uri.parse('$baseURL/user/vendor/register');

    if (experienceCert == null && cnicFront == null && cnicBack == null) {
      return '';
    }
    final response = await http.post(
      url,
      body: jsonString,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['message'] ==
          'Vendor Socialite Registered Successfully') {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('Vendor', response.body);
        pref.setString('token', jsonDecode(response.body)['data']['token']);
      }
      notifyListeners();
      return jsonDecode(response.body)['message'];
    } else {
      return jsonDecode(response.body)['message'];
    }
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

  updateAdminImage({File? image}) async {
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

  Future<User?> getuserdata(dynamic token) async {
    User? user;
    var url = Uri.parse('$baseURL/user/customer/profile?$token');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        user = jsonDecode(response.body);
      }
    }
    return user;
  }
}
