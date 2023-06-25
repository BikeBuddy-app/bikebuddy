import 'package:bike_buddy/constants/default_values.dart';
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:bike_buddy/utils/road_painter.dart';
import 'package:flutter/material.dart';
import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/pages/ride_details_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

List<Widget> tripDetails(BuildContext context, RideRecord trip) {
  const padding = 10.0;
  final duration = trip.time.toString();

  return [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: padding),
      child: Text(
        'Duration: $duration',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
    CustomPaint(
      size: const Size(100, 100),
      painter: RoadPainter(trip.route, 100, 100),
    ),
    if (debugInfo)
      Padding(
        padding: const EdgeInsets.symmetric(vertical: padding),
        child: Text(
          '[DEBUG] liczba punktow: ${trip.route.length}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
  ];
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

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(4),
      itemCount: trips.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Theme.of(context).colorScheme.tertiary,
          borderOnForeground: true,
          margin: const EdgeInsets.all(10),
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  "Trip ${index + 1}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tripDetails(context, trips[index])),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text(
                      'Details',
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
