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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              translations.h_ride_details_total_distance,
                              style: textTheme.titleMedium,
                            ),
                            SizedBox(height: textSize / 2),
                            Text(
                              '100 km',
                              style: textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              translations.h_ride_details_ride_duration,
                              style: textTheme.titleMedium,
                            ),
                            SizedBox(height: textSize / 2),
                            Text(
                              '45 minutes',
                              style: textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: textSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              translations.h_ride_details_maximum_speed,
                              style: textTheme.titleMedium,
                            ),
                            SizedBox(height: textSize / 2),
                            Text(
                              '30 km/h',
                              style: textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              translations.h_ride_details_average_speed,
                              style: textTheme.titleMedium,
                            ),
                            SizedBox(height: textSize / 2),
                            Text(
                              '15 km/h',
                              style: textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: textSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              translations.h_ride_details_calories_burnt,
                              style: textTheme.titleMedium,
                            ),
                            SizedBox(height: textSize / 2),
                            Text(
                              '500 kcal',
                              style: textTheme.bodyLarge,
                            ),
                          ],
                        ),
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
