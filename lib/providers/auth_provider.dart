import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  Future<void> registerUser({
    var firstName,
    var lastName,
    var email,
    var phoneNo,
    var password,
    var confirmPassword,
    var address,
  }) async {
    final url = Uri.parse(
        'https://washmesh.stackbuffers.com/api/user/customer/register?first_name=$firstName&last_name=$lastName&email=$email&phone=$phoneNo&password=$password&confirm_password=$confirmPassword&addres=$address');
    // final body = {
    //   'first_name': firstName,
    //   'last_name': lastName,
    //   'email': email,
    //   'phone': phoneNo,
    //   'password': password,
    //   'confirm_password': confirmPassword,
    //   'addres': address,
    // };
    final response = await http.post(url);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['message'] == 'Register Successfuly.') {
        return jsonDecode(response.body)['message'];
      }
    }
    notifyListeners();
  }
}
