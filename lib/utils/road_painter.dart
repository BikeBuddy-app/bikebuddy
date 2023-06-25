import 'dart:ui';

import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:flutter/material.dart';

class RoadPainter extends CustomPainter {
  final List<PositionRecord> route;
  final int width;
  final int height;

  RoadPainter(this.route, this.width, this.height);

  @override
  void paint(Canvas canvas, Size size) {
    const pointMode = PointMode.polygon;
    final points = _getPoints();
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

  List<Offset> _getPoints() {
    if (route.length <= 1) {
      return [Offset(width / 2, height / 2), Offset(width / 2, height / 2)];
    }

    var points = route
        .map((e) => e.position)
        .where((e) => e.longitude != null && e.latitude != null)
        .toList();

    double minLat = points.map((e) => e.latitude).reduce(minimum);
    double maxLat = points.map((e) => e.latitude).reduce(maximum);
    double minLon = points.map((e) => e.longitude).reduce(minimum);
    double maxLon = points.map((e) => e.longitude).reduce(maximum);

    double latRange = maxLat - minLat;
    double lonRange = maxLon - minLon;

    List<Offset> offsetPoints = [];
    for (var point in points) {
      double x = (point.longitude - minLon) / lonRange * 150;
      double y = (point.latitude - minLat) / latRange * 150;
      offsetPoints.add(Offset(x, y));
    }
    return offsetPoints;
  }

  double minimum(value, element) => value < element ? value : element;

  double maximum(value, element) => value > element ? value : element;
}
