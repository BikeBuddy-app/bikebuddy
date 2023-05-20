import 'package:bike_buddy/hive/entities/ride_item.dart';
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

class TripListWidget extends StatelessWidget {
  const TripListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<RideItem> trips = List.empty(growable: true);

    var box = Hive.box("ride_items");
    for (var value in box.values) {
      trips.add(value);
    }
    
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(4),
      itemCount: trips.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Theme.of(context).colorScheme.surface,
          borderOnForeground: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  "Trip ${index + 1}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  "Data",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
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
                      Navigator.pushNamed(context, RideDetailsPage.routeName, arguments: {'trip': trips[index]});
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
