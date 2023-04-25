import 'package:flutter/material.dart';

import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/pages/ride_details_page.dart';

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
    final List<String> trip = <String>['Trip1', 'Trip2', 'Trip3', 'Trip4'];
    final List<String> date = <String>["01.01.1900", "06.09.1969", "02.12.2012", "13.05.2020"];

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(4),
      itemCount: trip.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Theme.of(context).colorScheme.surface,
          borderOnForeground: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  trip[index],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  date[index],
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
                      Navigator.pushNamed(context, RideDetailsPage.routeName);
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
