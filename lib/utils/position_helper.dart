import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';

GeoPoint getGeoPoint(Position position) {
  return GeoPoint(
      latitude: position.latitude, longitude: position.longitude);
}