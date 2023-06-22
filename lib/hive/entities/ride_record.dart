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
}

@HiveType(typeId: 2)
class RideRecord {
  @HiveField(3)
  List<PositionRecord> route;
  @HiveField(4)
  Duration time;
  @HiveField(5)
  double maxSpeed;
  @HiveField(6)
  DateTime date;

  RideRecord()
      : route = List.empty(growable: true),
        time = Duration.zero,
        maxSpeed = 0.0,
        date = DateTime.now();

  void addRoutePoint(PositionRecord positionRecord) {
    route.add(positionRecord);
  }

  bool get fromThisWeek => DateTime.now().difference(date) < const Duration(days: 7);

  @override
  String toString() {
    return """Ride Record: 
    time - $time, 
    max speed - $maxSpeed, 
    route length - ${route.length} points
    date - $date""";
  }
}
