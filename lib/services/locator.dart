import 'dart:async';

import 'package:bike_buddy/constants/location_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import 'location.dart';

class Locator {
  StreamSubscription<Position>? positionStream;

  final void Function(Location location) changeCallback;

  Locator(this.changeCallback);

  void start() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
      try {
        positionStream =
            Geolocator.getPositionStream(locationSettings: kLocationSettings)
                .listen((Position? position) {
          if (position != null) {
            changeCallback(Location(position));
          }
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void stop() {
    positionStream?.cancel();
  }
}
