import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';

extension PostionToGeoPoint on Position {
  GeoPoint toGeoPoint() => GeoPoint(latitude: latitude, longitude: longitude);
}
