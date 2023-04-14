import 'package:hive_flutter/hive_flutter.dart';

part '../adapters/ride_item.g.dart';

@HiveType(typeId: 1)
class PositionTimestamp {
  @HiveField(1)
  String timestamp;
  @HiveField(2)
  String position;

  PositionTimestamp(this.timestamp, this.position);
}

@HiveType(typeId: 2)
class RideItem {
  @HiveField(3)
  List positionTimestamps;

  RideItem() : positionTimestamps = List.empty(growable: true);

  void add(PositionTimestamp positionTimestamp){
    positionTimestamps.add(positionTimestamp);
  }
}