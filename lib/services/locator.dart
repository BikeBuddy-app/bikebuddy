import 'dart:async';

import 'package:bike_buddy/constants/location_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import 'location.dart';

class Locator {
  late StreamSubscription<Position> _positionStream;

  final void Function(Location location) changeCallback;

  Locator(this.changeCallback);

  void start() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
      try {
        listenToPositionChanges();
      } catch (e) {
        debugPrint(
          e.toString(),
        );
      }
    }
  }

  void listenToPositionChanges() {
    _positionStream =
        Geolocator.getPositionStream(locationSettings: kLocationSettings)
            .listen((Position? position) {
      if (position != null) {
        changeCallback(
          Location(position),
        );
      }
    });
  }

  void stop() {
    _positionStream.cancel();
  }
}
