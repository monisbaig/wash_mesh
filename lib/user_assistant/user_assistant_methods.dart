import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:wash_mesh/models/user_models/user_direction_model.dart';
import 'package:wash_mesh/providers/user_provider/user_info_provider.dart';
import 'package:wash_mesh/user_assistant/user_request_assistant.dart';

import '../global_variables/map_keys.dart';

class UserAssistantMethods {
  static Future<String> reverseGeocoding(Position position, context) async {
    String apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';
    String readableAddress = '';
    var requestResponse = await UserRequestAssistant.receiveRequest(apiUrl);
    if (requestResponse != 'Error Occurred') {
      readableAddress = requestResponse['results'][0]['formatted_address'];

      UserDirectionModel userPickUpAddress = UserDirectionModel();
      userPickUpAddress.locationLatitude = position.latitude;
      userPickUpAddress.locationLongitude = position.longitude;
      userPickUpAddress.locationName = readableAddress;

      Provider.of<UserInfoProvider>(context, listen: false)
          .updatePickUpLocation(userPickUpAddress);
    }
    return readableAddress;
  }
}
