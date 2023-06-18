import 'dart:math';

import 'package:bike_buddy/extensions/position_extension.dart';
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:bike_buddy/constants/default_values.dart' as defaults;

import 'package:bike_buddy/utils/telemetry.dart';
import 'package:geolocator/geolocator.dart';

class MapDrawer {
  String? previousRoadKey;
  GeoPoint? markerPosition;
  final MapController mapController;

  bool drawRoads = true;

  MapDrawer() : mapController = MapController(initPosition: defaults.position.toGeoPoint());

  Future<void> draw(RideRecord rideRecord) async {
    await prepareMarker();
    List<GeoPoint> points = [for (PositionRecord p in rideRecord.route) p.position.toGeoPoint()];
    if (markerPosition != null) mapController.removeMarker(markerPosition!);
    markerPosition = points.last;
    mapController.changeLocation(markerPosition!);
    if (drawRoads == true && points.length > 1) {
      final roadKey = await drawRoad(points);
      if (previousRoadKey != null) {
        mapController.removeRoad(roadKey: previousRoadKey!);
      }
      previousRoadKey = roadKey;
    }
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

  Future<void> prepareMarker() async {
    return mapController.changeIconMarker(
      MarkerIcon(
        icon: Icon(
          Icons.directions_bike_outlined,
          size: 78,
          color: Colors.pink.shade300,
        ),
      ),
    );
  }

  void drawMarker(Position position, MarkerIcon icon, [double rotation = 0.0]) {
    mapController.addMarker(position.toGeoPoint(), markerIcon: icon, angle: convertDegToRad(position.heading + rotation));
  }

  void removeMarker(Position position) {
    mapController.removeMarker(position.toGeoPoint());
  }

  void changeMarkerLocation(Position oldPosition, Position newPosition, MarkerIcon icon) {
    print("przeniesienie markera");
    print(oldPosition.toJson().toString());
    print(newPosition.toJson().toString());
    mapController.changeLocationMarker(oldLocation: oldPosition.toGeoPoint(), newLocation: newPosition.toGeoPoint(), markerIcon: icon);
  }

  void resume() {
    zoomToDriver();
    enableRoadDrawing();
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

    var minLat =
        firstPos.latitude; //todo mozna zapisywac w tej klasie na biezaco jak punkty przybywaja
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
  }
}
