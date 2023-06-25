import 'dart:math' as math;

import 'package:bike_buddy/constants/default_values.dart' as default_values;
import 'package:bike_buddy/constants/general_constants.dart' as constants;
import 'package:bike_buddy/extensions/position_extension.dart';
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:bike_buddy/pages/ride/map_drawer.dart';
import 'package:bike_buddy/services/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

class BuddyDrawer {
  MarkerIcon buddyIcon = const MarkerIcon(
      icon: Icon(
    Icons.directions_bike,
    color: Colors.black,
    size: 50,
  ));

  late final RideRecord rideRecord;
  late final MapDrawer mapDrawer;

  late final Timer timer;

  Position currentPosition = default_values.position;
  Position prevPosition = default_values.position;
  int currentRouteIndex = 0;
  int lastRouteIndex = 1;

  final Color routeColor = Colors.amberAccent;

  bool drawRoads = true;

  BuddyDrawer(this.rideRecord, this.mapDrawer) {
    debugPrint("Initializing Buddy: [points: ${rideRecord.route.length}");
    timer = Timer(
        changeCallback: (duration) => drawBuddyPosition(duration),
        interval: const Duration(milliseconds: 500));
    currentPosition = rideRecord.route[currentRouteIndex].position;
    mapDrawer.drawMarker(currentPosition, buddyIcon);
    lastRouteIndex = rideRecord.route.length - 1;
  }

  Future<void> drawRoute() async {
    var route = rideRecord.route.map((e) => e.position.toGeoPoint()).toList();
    await mapDrawer.drawRoad(route, routeColor);
  }

  void start() {
    debugPrint("Buddy started his ride");
    timer.start();
  }

  void pause() {
    debugPrint("Buddy paused his ride");
    timer.pause();
  }

  void resume() {
    debugPrint("Buddy resumed his ride");
    timer.resume();
  }

  void stop() {
    debugPrint("Buddy stopped his ride");
    timer.stop();
  }

  void drawBuddyPosition(Duration duration) {
    updatePosition(duration);
  }

  void updatePosition(Duration currentDuration) {
    if (currentRouteIndex >= lastRouteIndex) {
      debugPrint("Buddy finished his route");
      timer.stop();
      return;
    }

    if (currentDuration.inMilliseconds >=
        rideRecord.route[currentRouteIndex + 1].timestamp.inMilliseconds) {
      mapDrawer.removeMarker(prevPosition);

      prevPosition = currentPosition;
      currentRouteIndex++;
      currentPosition = rideRecord.route[currentRouteIndex].position;

      mapDrawer.drawMarker(currentPosition, buddyIcon, -90);
      mapDrawer.removeMarker(prevPosition);
    } else {
      PositionRecord calculatedPos = getIntermediatePosition(
          rideRecord.route[currentRouteIndex],
          rideRecord.route[currentRouteIndex + 1],
          currentDuration);
      mapDrawer.removeMarker(prevPosition);
      prevPosition = currentPosition;
      currentPosition = calculatedPos.position;

      mapDrawer.drawMarker(currentPosition, buddyIcon, -90);
      mapDrawer.removeMarker(prevPosition);
    }
  }

  void zoomOutToShowWholeRoute() {
    mapDrawer.zoomOutToShowWholeRoute(rideRecord);
  }

  PositionRecord getIntermediatePosition(PositionRecord currentPos,
      PositionRecord nextPos, Duration currentDuration) {
    double distance = Geolocator.distanceBetween(
        currentPos.position.latitude,
        currentPos.position.longitude,
        nextPos.position.latitude,
        nextPos.position.longitude);
    double speed = distance /
        (nextPos.timestamp.inMilliseconds -
            currentPos.timestamp.inMilliseconds);
    int time =
        currentDuration.inMilliseconds - currentPos.timestamp.inMilliseconds;
    double distanceTravelled = speed * time;
    double bearing = vector_math.radians(Geolocator.bearingBetween(
        currentPos.position.latitude,
        currentPos.position.longitude,
        nextPos.position.latitude,
        nextPos.position.longitude));

    double deltaLat = distanceTravelled * math.cos(bearing);
    double deltaLon = distanceTravelled * math.sin(bearing);

    double newLat = currentPos.position.latitude +
        (deltaLat / (constants.mean_Earth_radius * math.pi / 180.0));
    double newLon = currentPos.position.longitude +
        (deltaLon /
            ((constants.mean_Earth_radius * math.pi / 180.0) *
                math.cos(currentPos.position.latitude)));

    PositionRecord intermediatePos = PositionRecord(
        Duration(milliseconds: currentDuration.inMilliseconds),
        Position(
            latitude: newLat,
            longitude: newLon,
            timestamp: currentPos.position.timestamp,
            accuracy: currentPosition.accuracy,
            altitude: currentPosition.altitude,
            heading: currentPosition.heading,
            speed: currentPosition.speed,
            speedAccuracy: currentPosition.speedAccuracy));

    return intermediatePos;
  }
}
