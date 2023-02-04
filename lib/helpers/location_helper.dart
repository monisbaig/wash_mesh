import 'dart:convert';

import 'package:http/http.dart' as http;

// const String googleApiKey = 'AIzaSyBUnLYfO9NuE_kl94r2UAKwzwD72HjAVfc';
const String googleApiKey = 'AIzaSyAFdwEshCku6zpICl_03d0uMo31JlxdFK4';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleApiKey');
    final response = await http.get(url);
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
