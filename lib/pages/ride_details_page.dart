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
    final translations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: const BBAppBar(),
      body: ListView(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                translations.h_ride_details,
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ),
          const Card(
            child: Text(
                "Lorem ipsum dolor sit amet,,\n\n\n consectetur adipiscing elit"),
          ),
          const Card(
            child: Text(
                "Lorem ipsum dolor sit amet,,\n\n\n consectetur adipiscing elit,"),
          ),
          const Card(
            child: Text(
                "Lorem ipsum dolor sit amet,,\n\n\n consectetur adipiscing elit,"),
          ),
        ],
      ),
    );
  }
}
