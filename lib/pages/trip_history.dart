import 'package:flutter/material.dart';
import 'package:bike_buddy/components/bike_buddy_bar.dart';

class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({super.key});

  static const String routeName = '/history';

  @override
  State<TripHistoryPage> createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: const TripListWidget(),
    );
  }
}

class TripListWidget extends StatelessWidget {
  const TripListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> trip = <String>['Trip1', 'Trip2', 'Trip3', 'Trip4'];
    final List<String> date = <String>[
      "01.01.1900",
      "06.09.1969",
      "02.12.2012",
      "13.05.2020"
    ];

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(4),
      itemCount: trip.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.black38,
          borderOnForeground: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(trip[index],
                    style: const TextStyle(color: Colors.green)),
                subtitle: Text(
                  date[index],
                  style: const TextStyle(color: Colors.deepOrange),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Details',
                        style: TextStyle(color: Colors.white10)),
                    onPressed: () {/* ... */},
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