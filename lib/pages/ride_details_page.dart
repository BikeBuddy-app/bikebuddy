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
    const double TextSize = 16.0;
    const DetailKeyTextStyle = TextStyle(
      fontSize: TextSize,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    const DetailValTextStyle = TextStyle(fontSize: TextSize);
    final translations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: const BBAppBar(),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(TextSize),
            child: Padding(
              padding: const EdgeInsets.all(TextSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(translations.h_ride_details, style: const TextStyle(fontSize: 22.0)),
                  const SizedBox(height: TextSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(translations.h_ride_details_total_distance, style: DetailKeyTextStyle,),
                            const SizedBox(height: TextSize / 2),
                            const Text('100 km', style: DetailValTextStyle,),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(translations.h_ride_details_ride_duration, style: DetailKeyTextStyle,),
                            const SizedBox(height: TextSize / 2),
                            const Text('45 minutes', style: DetailValTextStyle,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TextSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(translations.h_ride_details_maximum_speed, style: DetailKeyTextStyle,),
                            const SizedBox(height: TextSize / 2),
                            const Text('30 km/h', style: DetailValTextStyle,),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(translations.h_ride_details_average_speed, style: DetailKeyTextStyle,),
                            const SizedBox(height: TextSize / 2),
                            const Text('15 km/h', style: DetailValTextStyle,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TextSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(translations.h_ride_details_calories_burnt, style: DetailKeyTextStyle,),
                            const SizedBox(height: TextSize / 2),
                            const Text('500 kcal', style: DetailValTextStyle,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TextSize * 2),
                  Center(
                      child: Image.asset("images/map1.png", fit: BoxFit.cover)
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
