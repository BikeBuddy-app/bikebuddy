import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Duration locationFetchInterval = const Duration(seconds: 10);
  final void Function(String location) changeCallback;

  Location(this.changeCallback) {
    Timer.periodic(locationFetchInterval, (timer) => fetchCurrent());
    Timer.periodic(locationFetchInterval, (timer) => changeCallback(asString()));
  }

  Future<void> fetchCurrent() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        latitude = position.latitude;
        longitude = position.longitude;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  String asString() {
    if (latitude != null && longitude != null) {
      return 'Location{latitude: $latitude, longitude: $longitude}';
    }
    return 'Not initialized yet';
  }
}
