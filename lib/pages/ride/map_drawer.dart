import 'dart:math';

import 'package:bike_buddy/extensions/position_extension.dart';
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import 'package:bike_buddy/utils/telemetry.dart';
import 'package:geolocator/geolocator.dart';

class MapDrawer {
  String? previousRoadKey;
  Position? markerPosition;
  final MapController mapController;

  List<GeoPoint> currentRoad = [];

  static const int ROAD_POINT_LIMIT = 5;

  bool drawRoads = true;

  MapDrawer()
      : mapController = MapController(
    initMapWithUserPosition: const UserTrackingOption(
      enableTracking: true,
      unFollowUser: true,
    ),
  );

  Future<void> draw(Position position) async {
    if (markerPosition != null) removeMarker(markerPosition!);
    markerPosition = position;
    mapController.changeLocation(markerPosition!.toGeoPoint());

    if (drawRoads == false) return;

    if (currentRoad.length > ROAD_POINT_LIMIT) {
      startFollowingSegment();
    }
    currentRoad.add(position.toGeoPoint());

    adjustCurrentRoad();

    final roadKey = await drawRoad(currentRoad);
    if (previousRoadKey != null) {
      mapController.removeRoad(roadKey: previousRoadKey!);
    }
    previousRoadKey = roadKey;
  }

  void adjustCurrentRoad() {
    if (currentRoad.length == 1) {
      GeoPoint point = currentRoad.first;
      currentRoad = [
        GeoPoint(
            latitude: point.latitude - double.minPositive * 2,
            longitude: point.longitude - double.minPositive * 2),
        GeoPoint(
            latitude: point.latitude - double.minPositive,
            longitude: point.longitude - double.minPositive),
        point
      ];
    } else if (currentRoad.length == 2) {
      GeoPoint first = currentRoad.first;
      GeoPoint last = currentRoad.last;
      currentRoad = [
        first,
        GeoPoint(
            latitude: (last.latitude - first.latitude) / 2,
            longitude: (last.longitude - first.longitude)),
        last
      ];
    }
  }

  void startFollowingSegment() {
    currentRoad = [
      currentRoad.elementAt(currentRoad.length - 2),
      currentRoad.last
    ];
    previousRoadKey = null;
  }

  void startNewSegment() {
    currentRoad = [];
    previousRoadKey = null;
  }

  Future<String> drawRoad(List<GeoPoint> points, [Color? color]) async {
    return await mapController.drawRoadManually(
      points,
      RoadOption(
        roadColor: color ?? Colors.pink,
        roadWidth: 10,
        zoomInto: false,
      ),
    );
  }

  void drawMarker(Position position, MarkerIcon icon, [double rotation = 0.0]) {
    mapController.addMarker(position.toGeoPoint(),
        markerIcon: icon, angle: convertDegToRad(position.heading + rotation));
  }

  void removeMarker(Position position) {
    mapController.removeMarker(position.toGeoPoint());
  }

  void changeMarkerLocation(
      Position oldPosition, Position newPosition, MarkerIcon icon) {
    mapController.changeLocationMarker(
        oldLocation: oldPosition.toGeoPoint(),
        newLocation: newPosition.toGeoPoint(),
        markerIcon: icon);
  }

  void resume() {
    zoomToDriver();
    enableRoadDrawing();
    Position position = markerPosition!;
    markerPosition = null;
    draw(position);
  }

  void pause(RideRecord rideRecord) {
    // zoomOutToShowWholeRoute(rideRecord);
    disableRoadDrawing();
  }

  void zoomToDriver() {
    mapController.setZoom(zoomLevel: 19);
  }

  void zoomOutToShowWholeRoute(RideRecord rideRecord) {
    if (rideRecord.route.isEmpty) {
      return;
    }
    var firstPos = rideRecord.route[0].position;

    var minLat = firstPos
        .latitude; //todo mozna zapisywac w tej klasie na biezaco jak punkty przybywaja
    var maxLat = firstPos.latitude;
    var minLon = firstPos.longitude;
    var maxLon = firstPos.longitude;

    for (final routeRecord in rideRecord.route) {
      minLat = min(minLat, routeRecord.position.latitude);
      maxLat = max(maxLat, routeRecord.position.latitude);
      minLon = min(minLon, routeRecord.position.longitude);
      maxLon = max(maxLon, routeRecord.position.longitude);
    }

    BoundingBox box = BoundingBox(
      north: maxLat + 0.001,
      east: maxLon + 0.0001,
      south: minLat - 0.0001,
      west: minLon - 0.0001,
    );
    mapController.zoomToBoundingBox(box);
  }

  void enableRoadDrawing() {
    drawRoads = true;
  }

  void disableRoadDrawing() {
    drawRoads = false;
    startNewSegment();
  }
}
