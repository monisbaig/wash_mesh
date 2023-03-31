// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wash_mesh/models/user_models/orders_model.dart' as or;
import 'package:wash_mesh/models/user_models/place_order_model.dart';
import 'package:wash_mesh/models/user_models/vendor_accepted_order.dart' as vc;
import 'package:wash_mesh/user_screens/user_registration_form.dart';

import '../../models/user_models/mesh_categories_model.dart' as um;
import '../../models/user_models/user_model.dart' as u;
import '../../models/user_models/wash_categories_model.dart' as um;
import '../../models/user_models/wash_categories_model.dart';
import '../../user_map_integration/user_global_variables/user_global_variables.dart';
import '../../user_screens/user_login_form.dart';

class UserAuthProvider extends ChangeNotifier {
  static const baseURL = 'https://washmesh.stackbuffers.com/api';

  // User Authentication Code:

  registerUser(u.User userData, context) async {
    final url = Uri.parse('$baseURL/user/customer/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'first_name': userData.firstName,
        'last_name': userData.lastName,
        'phone': userData.phone,
        'email': userData.email,
        'address': userData.address,
        'image': userData.image,
        'password': userData.password,
        'confirm_password': userData.confirmPassword,
        'gender': userData.gender,
      }),
    );

    if (response.statusCode == 200) {
      dynamic result = await jsonDecode(response.body)['message'];

      saveFormData(
        email: userData.email,
        password: userData.password,
        name: userData.firstName,
        phone: userData.phone,
      );

      Fluttertoast.showToast(msg: result);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const UserLoginForm(),
        ),
      );
    } else {
      String? email = jsonDecode(response.body)['error'];

      Fluttertoast.showToast(msg: email!);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const UserRegistrationForm(),
        ),
      );
    }
    print(jsonDecode(response.body));
    notifyListeners();
    return u.User.fromJson(jsonDecode(response.body));
  }

  registerSocialUser({var name, var email, context}) async {
    final url = Uri.parse('$baseURL/user/customer/register/socialite');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'user_name': name,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      dynamic result = await jsonDecode(response.body)['message'];

      Fluttertoast.showToast(msg: result);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const UserLoginForm(),
        ),
      );
    } else {
      String? email = jsonDecode(response.body)['error'];

      Fluttertoast.showToast(msg: email!);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const UserRegistrationForm(),
        ),
      );
    }
    print(jsonDecode(response.body));
    notifyListeners();
    return u.User.fromJson(jsonDecode(response.body));
  }

  loginSocialUser() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    var googleMail = gUser.email;

    final url =
        Uri.parse('$baseURL/user/customer/login/socialite?input=$googleMail');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userToken', jsonDecode(response.body)['data']['token']);
      prefs.setBool('userLoggedIn', true);
      prefs.setString('userPersonalInfo', response.body);

      print(jsonDecode(response.body)['message']);
      print(response.body);
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      print(response.body);
    }
    notifyListeners();
  }

  signInWithGoogle(context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    var googleId = gUser.id;
    var googleName = gUser.displayName;
    var googleMail = gUser.email;

    await registerSocialUser(
        name: googleName, email: googleMail, context: context);

    if (gAuth.idToken != null) {
      Map userData = {
        'id': googleId,
        'name': googleName,
        'email': googleMail,
      };

      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users');
      userRef.child(googleId).set(userData);

      Fluttertoast.showToast(msg: 'Account has been created successfully.');

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      Fluttertoast.showToast(msg: 'Account has not been Created.');
    }
  }

  saveFormData({
    required dynamic email,
    required dynamic password,
    required dynamic name,
    required dynamic phone,
  }) async {
    try {
      final UserCredential user =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user != null) {
        Map userData = {
          'id': user.user!.uid,
          'name': name,
          'email': email,
          'phone': phone,
        };

        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('users');
        userRef.child(user.user!.uid).set(userData);
        activeUser = user;

        Fluttertoast.showToast(msg: 'Account has been created successfully.');
      } else {
        Fluttertoast.showToast(msg: 'Account has not been Created.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  loginUser({
    var input,
    var password,
  }) async {
    final url = Uri.parse(
        '$baseURL/user/customer/login?input=$input&password=$password');
    final response = await http.post(url);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['message'] == 'Login Successfully') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            'userToken', jsonDecode(response.body)['data']['token']);
        prefs.setBool('userLoggedIn', true);
        prefs.setString('userPersonalInfo', response.body);
      }
      return jsonDecode(response.body)['message'];
    } else {
      print(response.body);
    }
    notifyListeners();
  }

  updateUserData({var firstName, var lastName, var address, var phone}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('userToken');
    var jsonObject = {
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
      'phone': phone,
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
    // List<WashCategoryModel> list = [];
    // List<String> str = [];
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
    // List<WashCategoryModel> list = [];
    // List<String> str = [];
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
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return or.OrdersModel?.fromJson(jsonDecode(response.body));
    } else {
      return or.OrdersModel();
    }
  }

  // static Future<or.OrdersModel> orderMessage(orderId, context) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var token = pref.getString('userToken');
  //   final url = Uri.parse(
  //       '$baseURL/user/customer/order/all_accepted_vendors?order_id=$orderId');
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     if (jsonDecode(response.body)['message'] ==
  //         'This Customer Choose Service Provider against this Order') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(jsonDecode(response.body)['message']),
  //         ),
  //       );
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const UserBookingScreen(),
  //         ),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(jsonDecode(response.body)['message']),
  //         ),
  //       );
  //       await Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const UserBookingScreen(),
  //         ),
  //       );
  //     }
  //
  //     return or.OrdersModel?.fromJson(jsonDecode(response.body));
  //   } else {
  //     return or.OrdersModel();
  //   }
  // }

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
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);

      return jsonDecode(response.body)['message'];
    } else {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
    }
    notifyListeners();
  }

  updateWashService(List<int> wash, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    List<int> catlst = wash;

    var list = catlst.map((i) => i.toString()).join(",");

    var url =
        Uri.parse('$baseURL/user/vendor/category/apply/wash?category_id=$list');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);

      return jsonDecode(response.body)['message'];
    } else {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
    }
    notifyListeners();
  }

  updateMeshService(List<int> mesh, context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    List<int> catlst = mesh;

    var list = catlst.map((i) => i.toString()).join(",");

    var url =
        Uri.parse('$baseURL/user/vendor/category/apply/mesh?category_id=$list');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);

      return jsonDecode(response.body)['message'];
    } else {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
    }
    notifyListeners();
  }

  applyWashService({
    required List<int> wash,
    required BuildContext context,
    required String token,
  }) async {
    List<int> catlst = wash;

    var list = catlst.map((i) => i.toString()).join(",");

    var url =
        Uri.parse('$baseURL/user/vendor/category/apply/wash?category_id=$list');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);

      return jsonDecode(response.body)['message'];
    } else {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
    }
    notifyListeners();
  }

  applyMeshService({
    required List<int> mesh,
    required BuildContext context,
    required String token,
  }) async {
    List<int> catlst = mesh;

    var list = catlst.map((i) => i.toString()).join(",");

    var url =
        Uri.parse('$baseURL/user/vendor/category/apply/mesh?category_id=$list');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);

      return jsonDecode(response.body)['message'];
    } else {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
    }
    notifyListeners();
  }

  static Future<vc.VendorAcceptedOrder> getAcceptedVendorOrder(
      dynamic id) async {
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
      print(jsonDecode(response.body));
      return vc.VendorAcceptedOrder?.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
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
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
      return jsonDecode(response.body)['message'];
    } else {
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
    }
    notifyListeners();
  }

  updateUserImage({dynamic image}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('userToken');
    var jsonObject = {
      'image': image,
    };
    var jsonString = jsonEncode(jsonObject);

    var url = Uri.parse('$baseURL/user/customer/update/image');
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
