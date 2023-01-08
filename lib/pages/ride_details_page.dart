import 'package:flutter/material.dart';

import '../components/bike_buddy_bar.dart';

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
      appBar: CustomAppBar(),
      body: Container(),
    );
  }
}
