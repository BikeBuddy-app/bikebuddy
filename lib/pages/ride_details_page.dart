import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:flutter/material.dart';

class RideDetailsPage extends StatefulWidget {
  const RideDetailsPage({Key? key}) : super(key: key);

  static const String routeName = '/ride-details';

  @override
  State<RideDetailsPage> createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends State<RideDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BBAppBar(context),
      body: Container(),
    );
  }
}
