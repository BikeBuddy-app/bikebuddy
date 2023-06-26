import 'package:bike_buddy/constants/location_constants.dart';
import 'package:bike_buddy/extensions/position_extension.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';

part '../adapters/ride_record_adapter.dart';

@HiveType(typeId: 1)
class PositionRecord {
  @HiveField(1)
  Duration timestamp;
  @HiveField(2)
  Position position;

  PositionRecord(this.timestamp, this.position);

  PositionRecord.pause(this.timestamp) : position = POSITION_PAUSE;
}

@HiveType(typeId: 2)
class RideRecord {
  @HiveField(3)
  List<PositionRecord> _route;
  @HiveField(4)
  Duration time;
  @HiveField(5)
  double maxSpeed;
  @HiveField(6)
  DateTime date;

  RideRecord()
      : _route = List.empty(growable: true),
        time = Duration.zero,
        maxSpeed = 0.0,
        date = DateTime.now();

  List<PositionRecord> getRouteWithoutPause() {
    var routeCopy = List<PositionRecord>.from(_route);
    routeCopy.removeWhere((positionRecord) => positionRecord.position.longitude == POSITION_PAUSE.longitude &&
        positionRecord.position.latitude == POSITION_PAUSE.latitude);
    return routeCopy;
  }

  void addRoutePoint(PositionRecord positionRecord) {
    _route.add(positionRecord);
  }

  void addPause() {
    _route.add(PositionRecord(Duration.zero, POSITION_PAUSE));
  }

  Map<int, List<GeoPoint>> asSegments() {
    Map<int, List<GeoPoint>> segments = {};
    List<GeoPoint> currentSegment = [];
    int segmentCount = 0;
    for (PositionRecord positionRecord in _route) {
      if (positionRecord.position.longitude == POSITION_PAUSE.longitude &&
          positionRecord.position.latitude == POSITION_PAUSE.latitude) {
        segments[segmentCount++] = currentSegment;
        currentSegment = [];
      } else {
        currentSegment.add(positionRecord.position.toGeoPoint());
      }
    }
    segments[segmentCount] = currentSegment;
    return segments;
  }

  bool get fromThisWeek =>
      DateTime.now().difference(date) < const Duration(days: 7);

  @override
  String toString() {
    return """Ride Record: 
    time - $time, 
    max speed - $maxSpeed, 
    route length - ${getRouteWithoutPause().length} points
    date - $date""";
  }
}
