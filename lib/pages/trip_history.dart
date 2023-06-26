import 'package:bike_buddy/constants/default_values.dart';
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:bike_buddy/utils/road_painter.dart';
import 'package:bike_buddy/utils/telemetry.dart';
import 'package:flutter/material.dart';
import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/pages/ride_details_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({super.key});

  static const String routeName = '/history';

  @override
  State<TripHistoryPage> createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BBAppBar(),
      body: TripListWidget(),
    );
  }
}

Widget tripDetailCard(BuildContext context, String content) {
  const elevation = 1.0;
  const margin = 8.0;
  const padding = 10.0;
  
  return Card(
    elevation: elevation,
    margin: const EdgeInsets.symmetric(vertical: margin),
    color: Theme.of(context).colorScheme.tertiary,
    child: Padding(
      padding: const EdgeInsets.all(padding), 
      child:Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
  )));
}

List<Widget> tripDetails(BuildContext context, RideRecord trip) {
  final duration = trip.time;
  final distance = calculateDistance(trip.asSegments());
  final translations = AppLocalizations.of(context)!;

  return [
      tripDetailCard(context, '${translations.trip_detail_duration}: $duration'),
      tripDetailCard(context, '${translations.h_ride_details_total_distance}: ${distance/1000} km'),
  ];
}

Widget tripRoute(BuildContext context, RideRecord trip) {
  return CustomPaint(
      size: const Size(100, 100),
      painter: RoadPainter(trip.getRouteWithoutPause(), 100, 100),
  );
}

class TripListWidget extends StatelessWidget {
  const TripListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<RideRecord> trips = List.empty(growable: true);

    final Box<RideRecord> box = Hive.box("ride_records");
    for (RideRecord value in box.values) {
      trips.add(value);
    }

    final translations = AppLocalizations.of(context)!;

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(4.0),
      itemCount: trips.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Theme.of(context).colorScheme.tertiary,
          borderOnForeground: true,
          margin: const EdgeInsets.all(10.0),
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  "${index + 1}# ${translations.trip_tile_title}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tripRoute(context, trips[index]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: tripDetails(context, trips[index])
                      )
                    ]
                )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text(
                      translations.trip_tile_button_text,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RideDetailsPage.routeName,
                          arguments: {'trip': trips[index]});
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
