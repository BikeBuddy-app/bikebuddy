import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  RideRecord rideRecord = RideRecord();
  const Position mockPosition = Position(
      longitude: 10,
      latitude: 12,
      accuracy: 2,
      altitude: 4,
      heading: 1,
      speed: 8,
      speedAccuracy: 16,
      floor: 32,
      timestamp: null);
  setUp(() {
    rideRecord = RideRecord();
  });
  test('Should have one empty segment after initialization', () {
    var segments = rideRecord.asSegments();
    expect(segments, {0: []});
  });

  test('Should have one segment if no pause', () {
    rideRecord.addRoutePoint(
        PositionRecord(const Duration(seconds: 12), mockPosition));

    var segments = rideRecord.asSegments();
    expect(segments, {
      0: [GeoPoint(latitude: 12, longitude: 10)]
    });
  });
  test('Should have two segments if pause', () {
    rideRecord.addRoutePoint(
        PositionRecord(const Duration(seconds: 12), mockPosition));
    rideRecord.addPause();
    var segments = rideRecord.asSegments();
    expect(segments, {
      0: [
        GeoPoint(latitude: 12, longitude: 10),
      ],
      1: [],
    });
  });
  test('Should have three segments if 2 pauses', () {
    rideRecord.addRoutePoint(
        PositionRecord(const Duration(seconds: 12), mockPosition));
    rideRecord.addPause();
    rideRecord.addRoutePoint(
        PositionRecord(const Duration(seconds: 12), mockPosition));
    rideRecord.addPause();
    var segments = rideRecord.asSegments();
    expect(segments, {
      0: [
        GeoPoint(latitude: 12, longitude: 10),
      ],
      1: [
        GeoPoint(latitude: 12, longitude: 10),
      ],
      2: []
    });
  });
}
