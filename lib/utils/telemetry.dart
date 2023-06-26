import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

import 'package:bike_buddy/constants/general_constants.dart' as constants;
import 'package:bike_buddy/extensions/double_extension.dart';
import 'package:bike_buddy/hive/entities/ride_record.dart';

/// Zwraca długość trasy __w metrach__
double calculateDistance(Map<int, List<GeoPoint>> segments) {
  double distance = 0;
  for (List<GeoPoint> segment in segments.values) {
    if (segment.length < 2) continue;
    for (var i = 0; i < segment.length - 1; i++) {
      var start = segment[i];
      var end = segment[i + 1];
      distance += Geolocator.distanceBetween(
        start.latitude,
        start.longitude,
        end.latitude,
        end.longitude,
      ).roundToDouble();
    }
  }

  return distance;
}

double calculateAverageSpeed(Duration duration, double distance) {
  var result = double.parse((distance / duration.inSeconds).toStringAsFixed(1));
  return result;
}

double calculateBurnedCalories(Duration trainingDuration, int weight) {
  // Spalone cal = MET * waga ciała (kg) * czas trwania (godziny) * 5
  // cal / 1000 => kcal
  final calories =
      constants.MET * weight * trainingDuration.inSeconds / 3600.0 * 1.5;
  return calories.toPrecision(1);
}

/// convert degrees to radians in range <-pi, pi>
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

// calculating things from hive

/// Zwraca sume czasu tras
Duration calcTotalRideDuration(Iterable<RideRecord> records) {
  return records.fold(Duration.zero, (Duration time, value) {
    return time + value.time;
  });
}

/// Zwraca sume długości tras __w metrach__
double calcTotalDistance(Iterable<RideRecord> records) {
  return records.fold(0, (double distance, value) {
    return distance + calculateDistance(value.asSegments());
  });
}

/// Zwraca długość najdłuższej z podanych tras __w metrach__
double calcMaxDistance(Iterable<RideRecord> records) {
  return records.fold(0, (double max, value) {
    final distance = calculateDistance(value.asSegments());
    return distance > max ? distance : max;
  });
}

/// Zwraca sumę spalonych kalorii
double calcTotalCalories(Iterable<RideRecord> records, int weight) {
  return records.fold(0, (double distance, value) {
    return distance + calculateBurnedCalories(value.time, weight);
  });
}

int calcStreak(Iterable<RideRecord> records) {
  int streak = 0;
  DateTime? date;

  for (RideRecord record in records) {
    // ignore: unnecessary_null_comparison
    if (date == null) {
      streak = 1;
      date = DateUtils.dateOnly(record.date);
      continue;
    }

    final daysPassed = DateUtils.dateOnly(record.date).difference(date).inDays;
    if (daysPassed == 1) {
      streak += 1;
      date = DateUtils.dateOnly(record.date);
      continue;
    }
    if (daysPassed > 1) {
      streak == 1;
      date = DateUtils.dateOnly(record.date);
    }
  }

  if (date == null ||
      DateUtils.dateOnly(DateTime.now()).difference(date).inDays > 1) {
    streak = 0;
  }

  return streak;
}

int calculateTotalXp(Iterable<RideRecord> records) {
  return calcTotalDistance(records).floor();
}

int calculateLevel(int xp) {
  //wygląda strasznie ale wzór prosty
  //pierszy lvl wymaga 500xp, drugi 1000xp, trzeci 1500xp etc.
  return (0.02 * (-25 + math.sqrt(625 + 10 * xp))).floor() + 1;
}

int calculateTotalXpToReachLvl(int level) {
  return 250 * level * (level - 1);
}
