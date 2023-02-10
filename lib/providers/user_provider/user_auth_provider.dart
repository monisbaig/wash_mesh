import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/models/user_models/Meshusermodel.dart';
import 'package:wash_mesh/models/user_models/Place.dart';

import '../../models/user_models/Categories.dart' as um;
import '../../models/user_models/Categories.dart';
import '../../models/user_models/user_registration_model.dart';

class UserAuthProvider extends ChangeNotifier {
  static const baseURL = 'https://washmesh.stackbuffers.com/api';

  // User Authentication Code:

  Future<User> registerUser(User userData) async {
    final url = Uri.parse('$baseURL/user/customer/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(userData.toJson()),
    );
    try {
      if (response.statusCode == 200) {
        print(User.fromJson(jsonDecode(response.body)));
        return User.fromJson(jsonDecode(response.body));
      }
      notifyListeners();
      return User.fromJson(jsonDecode(response.body));
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
        // pref.setString('User', response.body);
        pref.setString('userToken', jsonDecode(response.body)['data']['token']);
        print(jsonDecode(response.body)['data']['token']);
      }
      return jsonDecode(response.body)['message'];
    } else {
      print(response.body);
    }
    notifyListeners();
  }

  updateUserData({var firstName, var lastName, var address}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('userToken');
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
    var token = pref.getString('userToken');
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

  static Future<Meshusermodel> Getmeshcategories() async {
    List<Meshusermodel> list = [];
    final url = Uri.parse('$baseURL/mesh/categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> lst = jsonDecode(response.body);

      // List<WashCategoryModel> list=[];
      // list.add();
      // print(da.data![0].name);
      return Meshusermodel.fromJson(jsonDecode(response.body));
    } else {
      return Meshusermodel();
    }
  }

  static Future<nameid> getmeshnames() async {
    List<WashCategoryModel> list = [];
    List<String> str = [];
    final url = Uri.parse('$baseURL/mesh/categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> lst = jsonDecode(response.body);

      // List<WashCategoryModel> list=[];
      // list.add();
      // print(da.data![0].name);
      List<String> str = [];
      List<int> id = [];
      var dt = WashCategoryModel.fromJson(jsonDecode(response.body));
      List.generate(dt.data!.length, (index) {
        str.add(dt.data!.elementAt(index).name!);
        id.add(int.parse(dt.data!.elementAt(index).id!.toString()));
      });
      nameid i = nameid.nameid(str, id);
      return i;
    } else {
      return nameid();
    }
  }

  static Future<nameid> getwashnames() async {
    List<WashCategoryModel> list = [];
    List<String> str = [];
    final url = Uri.parse('$baseURL/wash/categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> lst = jsonDecode(response.body);

      // List<WashCategoryModel> list=[];
      // list.add();
      // print(da.data![0].name);
      List<String> str = [];
      List<int> id = [];
      var dt = WashCategoryModel.fromJson(jsonDecode(response.body));
      List.generate(dt.data!.length, (index) {
        str.add(dt.data!.elementAt(index).name!);
        id.add(int.parse(dt.data!.elementAt(index).id!.toString()));
      });
      nameid i = nameid.nameid(str, id);
      return i;
    } else {
      return nameid();
    }
  }

  static Future<um.WashCategoryModel> getwashcategories() async {
    final url = Uri.parse('$baseURL/wash/categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> lst = jsonDecode(response.body);

      // List<WashCategoryModel> list=[];
      // list.add();
      // print(da.data![0].name);
      return um.WashCategoryModel?.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      return um.WashCategoryModel();
    }
  }

  placewashorder(placemodel p) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('userToken');
    var jsonObject = jsonEncode(p);
    var url = Uri.parse('$baseURL/user/order/place');
    var response = await http.post(
      url,
      body: jsonObject,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['message']);
      return jsonDecode(response.body)['message'];
    } else {
      print(jsonDecode(response.body)['message']);
      print(token);
    }
    notifyListeners();
  }
}

class nameid {
  List<String> lstname = [];
  List<int> lstcatid = [];
  nameid() {}
  nameid.nameid(List<String> name, List<int> id) {
    lstname = name;
    lstcatid = id;
  }
}
