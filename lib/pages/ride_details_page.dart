import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:bike_buddy/utils/telemetry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bike_buddy/components/bb_appbar.dart';

class RideDetailsPage extends StatefulWidget {
  const RideDetailsPage({super.key});

  static const String routeName = '/ride-details';
  @override
  State<RideDetailsPage> createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends State<RideDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final translations = AppLocalizations.of(context)!;

    final textSize = textTheme.titleMedium?.fontSize ?? 16;
    const double MapBorderRadius = 10.0;

    var tripInfo = ModalRoute.of(context)?.settings.arguments as Map;
    RideRecord trip = tripInfo['trip'];
    var distance = calculateDistance(trip.route);
    var averageSpeed = double.parse((calculateAverageSpeed(trip.route) * 3.6).toStringAsFixed(1));
    var burnedCalories = calculateBurnedCalories(trip.time);
    var maxCurrentSpeed = trip.maxSpeed;

    return Scaffold(
      appBar: const BBAppBar(),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(textSize),
            child: Padding(
              padding: EdgeInsets.all(textSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(translations.h_ride_details, style: const TextStyle(fontSize: 22.0)),
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
                        value: trip.time.toString(),
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
                  Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(MapBorderRadius),
                          child: Image.asset("images/map1.png", fit: BoxFit.cover))),
                ],
              ),
            ),
          )
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
