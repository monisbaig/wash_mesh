class PlaceLocation {
  final double? latitude;
  final double? longitude;
  final String? address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}

class PlaceModel {
  final String? id;
  final PlaceLocation? location;

  PlaceModel({
    required this.id,
    required this.location,
  });
}
