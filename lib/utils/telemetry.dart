import 'package:bike_buddy/constants/general_constants.dart';
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

double calculateDistance(List<PositionRecord> route) {
  if (route.length < 2) return 0.0;
  
  var distance = 0.0;
  for (var i = 0; i < route.length - 1; i++) {
    var start = route[i].position;
    var end = route[i+1].position;
    distance += (Geolocator.distanceBetween(start.latitude, start.longitude,
        end.latitude, end.longitude)).roundToDouble();
  }

  return distance;
}

double calculateAverageSpeed(List<PositionRecord> route) {
  var distance = calculateDistance(route);
  var result = double.parse((distance / route[route.length-1].timestamp.inSeconds).toStringAsFixed(1));
  return result;
}

double calculateBurnedCalories(Duration time){
  // Spalone kalorie = MET * waga ciała (kg) * czas trwania (godziny) * 5
  return double.parse((MET * weight * time.inSeconds / 3600.0  * 5).toStringAsFixed(1));
}
