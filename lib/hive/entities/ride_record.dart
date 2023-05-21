import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'ride_record.g.dart';

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

  RideRecord() : route = List.empty(growable: true), time = Duration.zero;

  void addRoutePoint(PositionRecord positionRecord){
    route.add(positionRecord);
  }

  void setTime(Duration time){
    this.time = time;
  }
}