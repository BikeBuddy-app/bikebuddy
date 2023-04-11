import 'package:bike_buddy/services/locator.dart';
import 'package:bike_buddy/services/timer.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'ride_item.g.dart';

@HiveType(typeId: 0)
class RideItem {
  @HiveField(0)
  late Locator locator;
  @HiveField(1)
  late Timer timer;

  RideItem(this.locator, this.timer);
}