import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/admin_assistant/admin_request_assistant.dart';
import 'package:wash_mesh/models/admin_models/admin_direction_model.dart';
import 'package:wash_mesh/providers/admin_provider/admin_info_provider.dart';

import '../global_variables/map_keys.dart';

class AdminAssistantMethods {
  static Future<String> reverseGeocoding(Position position, context) async {
    String apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';
    String readableAddress = '';
    var requestResponse = await AdminRequestAssistant.receiveRequest(apiUrl);
    if (requestResponse != 'Error Occurred') {
      readableAddress = requestResponse['results'][0]['formatted_address'];

      AdminDirectionModel adminPickUpAddress = AdminDirectionModel();
      adminPickUpAddress.locationLatitude = position.latitude;
      adminPickUpAddress.locationLongitude = position.longitude;
      adminPickUpAddress.locationName = readableAddress;

      Provider.of<AdminInfoProvider>(context, listen: false)
          .updatePickUpLocation(adminPickUpAddress);
    }
    return readableAddress;
  }
}
