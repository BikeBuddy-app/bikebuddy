import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Location(Position position)
      : latitude = position.latitude,
        longitude = position.longitude;

  String asString() {
    return 'Location{latitude: $latitude, longitude: $longitude}';
  }
}
