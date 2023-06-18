import 'package:bike_buddy/constants/general_constants.dart' as constants;
import 'package:bike_buddy/extensions/double_extension.dart';
import 'package:vector_math/vector_math.dart' as vector_math;
import 'dart:math' as math;
import 'package:bike_buddy/extensions/double_extension.dart';
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:geolocator/geolocator.dart';

double calculateDistance(List<PositionRecord> route) {
  if (route.length < 2) return 0.0;

  var distance = 0.0;
  for (var i = 0; i < route.length - 1; i++) {
    var start = route[i].position;
    var end = route[i + 1].position;
    distance += Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    ).roundToDouble();
  }

  return distance;
}

double calculateAverageSpeed(Duration duration, double distance) {
  var result = double.parse((distance / duration.inSeconds).toStringAsFixed(1));
  return result;
}

double calculateBurnedCalories(List<PositionRecord> route, int weight) {
  // Spalone cal = MET * waga ciała (kg) * czas trwania (godziny) * 5
  // cal / 1000 => kcal
  final calories =
      constants.MET * weight * route[route.length - 1].timestamp.inSeconds / 3600.0 * 1.5;
  return calories.toPrecision(1);
}

// convert degrees to radians in range <-pi, pi>
double convertDegToRad(double deg) {
  //var rad = deg * constants.PI / 180;
  var rad = vector_math.radians(deg) % (2 * math.pi);
  if (rad > math.pi) {
    rad -= 2 * math.pi;
  } else if (rad < -math.pi) {
    rad += 2 * math.pi;
  }
  return rad;
}
