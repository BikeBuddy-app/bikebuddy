import 'dart:async';

import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:bike_buddy/pages/ride/map_drawer.dart';
import 'package:bike_buddy/utils/telemetry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../components/map/bb_map.dart';
import '../utils/position_helper.dart';

class RideDetailsPage extends StatefulWidget {
  const RideDetailsPage({super.key});

  static const String routeName = '/ride-details';

  @override
  State<RideDetailsPage> createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends State<RideDetailsPage> {
  late final MapDrawer mapDrawer;
  late RideRecord rideRecord;
  late List<GeoPoint> points;

  zoomOut() {
    mapDrawer.zoomOutToShowWholeRoute(rideRecord);
    mapDrawer.enableRoadDrawing();
    mapDrawer.drawRoad(points);
    return;
  }

  @override
  void initState() {
    mapDrawer = MapDrawer.fromGeoPoint(GeoPoint(latitude: 100, longitude: 100));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 2), zoomOut);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final translations = AppLocalizations.of(context)!;

    final textSize = textTheme.titleMedium?.fontSize ?? 16;

    var tripInfo = ModalRoute.of(context)?.settings.arguments as Map;
    rideRecord = tripInfo['trip'];
    List<PositionRecord> route = rideRecord.route;
    // MapDrawer mapDrawer = MapDrawer(route.last.position);
    double distance = calculateDistance(route);
    double averageSpeed =
        double.parse((calculateAverageSpeed(route) * 3.6).toStringAsFixed(1));
    double burnedCalories = calculateBurnedCalories(rideRecord.time);
    double maxCurrentSpeed = rideRecord.maxSpeed;

    points = [for (PositionRecord p in route) getGeoPoint(p.position)];

    return Scaffold(
      appBar: const BBAppBar(),
      body: Stack(
        children: [
          BBMap(controller: mapDrawer.mapController),
          Column(
            children: [
              Card(
                margin: EdgeInsets.all(textSize),
                child: Padding(
                  padding: EdgeInsets.all(textSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(translations.h_ride_details,
                          style: const TextStyle(fontSize: 22.0)),
                      SizedBox(height: textSize),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DetailItem(
                            label: translations.h_ride_details_total_distance,
                            value: '${distance / 1000} km',
                          ),
                          DetailItem(
                            label: translations.h_ride_details_ride_duration,
                            value: rideRecord.time.toString(),
                          ),
                        ],
                      ),
                      SizedBox(height: textSize),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DetailItem(
                            label: translations.h_ride_details_maximum_speed,
                            value: '$maxCurrentSpeed km/h',
                          ),
                          DetailItem(
                            label: translations.h_ride_details_average_speed,
                            value: '$averageSpeed km/h',
                          ),
                        ],
                      ),
                      SizedBox(height: textSize),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DetailItem(
                            label: translations.h_ride_details_calories_burnt,
                            value: '$burnedCalories kcal',
                          ),
                        ],
                      ),
                      SizedBox(height: textSize * 2),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const DetailItem({
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double textSize = textTheme.titleMedium?.fontSize ?? 16;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: textTheme.titleMedium,
          ),
          SizedBox(height: textSize / 2),
          Text(
            value,
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
