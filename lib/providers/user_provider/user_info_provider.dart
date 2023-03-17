import 'package:flutter/material.dart';
import 'package:wash_mesh/models/user_models/user_direction_model.dart';

class UserInfoProvider extends ChangeNotifier {
  UserDirectionModel? userPickUpLocation;

  void updatePickUpLocation(UserDirectionModel userPickupAddress) {
    userPickUpLocation = userPickupAddress;
    notifyListeners();
  }
}
