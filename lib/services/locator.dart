import 'dart:async';

import 'package:bike_buddy/constants/location_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Locator {
  bool started = false;

  late StreamSubscription<Position> _positionStream;

  final void Function(Position position) changeCallback;

  Locator(this.changeCallback);

  Future<Position> get currentPosition async {
    assert(started);
    return await Geolocator.getCurrentPosition();
  }

  Future<void> start() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
      try {
        listenToPositionChanges();
        started = true;
      } catch (e) {
        debugPrint(
          e.toString(),
        );
      }
    }
  }

  void listenToPositionChanges() {
    _positionStream = Geolocator.getPositionStream(locationSettings: kLocationSettings)
        .listen((Position? position) {
      if (position != null) {
        changeCallback(
          position,
        );
      }
    });
  }

  void stop() {
    _positionStream.cancel();
  }
}
