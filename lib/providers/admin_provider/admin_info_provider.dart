import 'package:flutter/material.dart';
import 'package:wash_mesh/models/admin_models/admin_direction_model.dart';

class AdminInfoProvider extends ChangeNotifier {
  AdminDirectionModel? adminPickUpLocation;

  void updatePickUpLocation(AdminDirectionModel adminPickupAddress) {
    adminPickUpLocation = adminPickupAddress;
    notifyListeners();
  }
}
