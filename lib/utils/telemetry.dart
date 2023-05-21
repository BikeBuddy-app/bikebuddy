import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:geolocator/geolocator.dart';

double calculateDistance(List<PositionRecord> route) {
  if (route.length < 2) {
    return 0.0;
  }

  var distance = 0.0;
  for (var i = 1; i < route.length - 1; i++) {
    var start = route[i].position;
    var end= route[i+1].position;

    distance += Geolocator.distanceBetween(start.latitude, start.longitude,
        end.latitude, end.longitude);
  }
  return distance;
}