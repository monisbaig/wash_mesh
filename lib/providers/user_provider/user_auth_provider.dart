import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/models/user_models/orders_model.dart' as or;
import 'package:wash_mesh/models/user_models/place_order_model.dart';
import 'package:wash_mesh/models/user_models/vendor_accepted_order.dart' as vc;

import '../../models/user_models/mesh_categories_model.dart' as um;
import '../../models/user_models/user_model.dart';
import '../../models/user_models/wash_categories_model.dart' as um;
import '../../models/user_models/wash_categories_model.dart';

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
        'secret-key':
            'a8sd78j%\$#a^&Hfaf**566\$##hwe!\/\]55adad\4A@#PLDH dfu59 2033 3y58fsd6gf21ea2"}{@#:#\$23452asd d[',
      },
    );
    notifyListeners();
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      return 'Registration Failed';
    }
  }

  static Future<nameid> getMeshNames() async {
    List<WashCategoryModel> list = [];
    List<String> str = [];
    final url = Uri.parse('$baseURL/mesh/categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
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

  static Future<nameid> getWashNames() async {
    List<WashCategoryModel> list = [];
    List<String> str = [];
    final url = Uri.parse('$baseURL/wash/categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
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

  static Future<um.WashCategoryModel> getWashCategories() async {
    final url = Uri.parse('$baseURL/wash/categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return um.WashCategoryModel?.fromJson(jsonDecode(response.body));
    } else {
      return um.WashCategoryModel();
    }
  }

  static Future<um.MeshCategoryModel> getMeshCategories() async {
    final url = Uri.parse('$baseURL/mesh/categories');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return um.MeshCategoryModel?.fromJson(jsonDecode(response.body));
    } else {
      return um.MeshCategoryModel();
    }
  }

  static Future<or.OrdersModel> getOrders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('userToken');
    final url = Uri.parse('$baseURL/user/order/all_orders');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return or.OrdersModel?.fromJson(jsonDecode(response.body));
    } else {
      return or.OrdersModel();
    }
  }

  placeOrder(PlaceOrderModel p, context) async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonDecode(response.body)['message']),
        ),
      );
      return jsonDecode(response.body)['message'];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonDecode(response.body)['message']),
        ),
      );
    }
    notifyListeners();
  }

  applyVendor(List<int> wash, List<int> mesh, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    List<int> catlst = wash + mesh;

    var list = catlst.map((i) => i.toString()).join(",");

    var url =
        Uri.parse('$baseURL/user/vendor/category/apply?category_id=$list');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonDecode(response.body)['message']),
        ),
      );

      return jsonDecode(response.body)['message'];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonDecode(response.body)['message']),
        ),
      );
    }
    notifyListeners();
  }

  static Future<vc.VendorAcceptedOrder> getAcceptedVendorOrder(
      dynamic id, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('userToken');
    final url = Uri.parse(
        '$baseURL/user/customer/order/all_accepted_vendors?order_id=$id');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return vc.VendorAcceptedOrder?.fromJson(jsonDecode(response.body));
    } else {
      return vc.VendorAcceptedOrder();
    }
  }

  userAcceptOrder({dynamic orderId, dynamic vendorId, context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('userToken');

    var url = Uri.parse(
        '$baseURL/user/customer/order/accept_vendor_request?order_id=$orderId&vendor_id=$vendorId');
    var response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonDecode(response.body)['message']),
        ),
      );
      return jsonDecode(response.body)['message'];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonDecode(response.body)['message']),
        ),
      );
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
