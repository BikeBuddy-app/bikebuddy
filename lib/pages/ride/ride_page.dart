import 'dart:math';

import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/components/custom_round_button.dart';
import 'package:bike_buddy/components/map/bb_map.dart';
import 'package:bike_buddy/hive/entities/ride_item.dart';
import 'package:bike_buddy/pages/ride_details_page.dart';
import 'package:bike_buddy/services/locator.dart';
import 'package:bike_buddy/services/timer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RidePage extends StatefulWidget {
  const RidePage({super.key});

  static const String routeName = '/ride';

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  bool isRideActive = true;
  String timerValue = "00:00:00";
  String currentPosition = "None";

  late final Timer timer;
  late final Locator locator;
  late final MapController mapController;

  final List<Position> route = List.empty(growable: true);
  GeoPoint currentGeoPoint =
      GeoPoint(latitude: 47.4358055, longitude: 8.4737324);

  var rideItemsBox = Hive.box("ride_items");
  var rideItem = RideItem();

  @override
  void initState() {
    initializeTimer();
    initializeLocator();
    initializeMapController();
    super.initState();
  }

  void initializeMapController() {
    mapController = MapController(
      initMapWithUserPosition: false,
      initPosition: currentGeoPoint,
    );
  }

  void savePositionTimestamp() {
    var positionTimestamp = PositionTimestamp(timerValue, currentPosition);
    rideItem.add(positionTimestamp);
  }

  void saveCurrentRide() {
    rideItemsBox.add(rideItem);
  }

  void initializeLocator() {
    locator = Locator(
      (newPosition) => setState(() {
        this.currentPosition = newPosition.toString();
        this.currentGeoPoint = GeoPoint(
            latitude: newPosition.latitude, longitude: newPosition.longitude);
        this.route.add(newPosition);
      }),
    );
    locator.start();
  }

  void initializeTimer() {
    timer = Timer(
      (timerValue) => setState(() {
        this.timerValue = timerValue.toString();
      }),
    );
    timer.start();
  }

  void resumeButtonHandler() {
    setState(() {
      isRideActive = true;
    });
    timer.resume();
    zoomToDriver();
    mapController.enableTracking();
  }

  void pauseButtonHandler() {
    setState(() {
      isRideActive = false;
    });
    timer.pause();
    mapController.disabledTracking();
    zoomOutToShowWholeRoute();
  }

  void zoomOutToShowWholeRoute() {
    if (route.isEmpty) {
      return;
    }
    var minLat = route[0].latitude;
    var maxLat = route[0].latitude;
    var minLon = route[0].longitude;
    var maxLon = route[0].longitude;

    for (final position in route) {
      minLat = min(minLat, position.latitude);
      maxLat = max(maxLat, position.latitude);
      minLon = min(minLon, position.longitude);
      maxLon = max(maxLon, position.longitude);
    }

    BoundingBox box = BoundingBox(
      north: maxLat,
      east: maxLon,
      south: minLat,
      west: minLon,
    );

    mapController.zoomToBoundingBox(box);
  }

  void zoomToDriver() {
    mapController.setZoom(zoomLevel: 19);
  }

  void resetMapPosition() {
    mapController.currentLocation();
    mapController.enableTracking();
  }

  void stopButtonHandler() {
    locator.stop();
    timer.stop();
    saveCurrentRide();

    Navigator.pushReplacementNamed(context, RideDetailsPage.routeName);
  }

  late final List<Widget> activeRideButtons = [
    CustomRoundButton.large(
      icon: const Icon(
        Icons.pause,
        size: 60,
      ),
      onPressed: pauseButtonHandler,
    ),
  ];

  late final List<Widget> inactiveRideButtons = [
    CustomRoundButton.large(
      backgroundColor: Colors.green,
      icon: const Icon(
        Icons.play_arrow,
        size: 60,
      ),
      onPressed: resumeButtonHandler,
    ),
    const SizedBox(width: 10),
    CustomRoundButton.medium(
      backgroundColor: Colors.redAccent,
      icon: const Icon(
        Icons.stop,
        size: 48,
      ),
      onPressed: () {},
      onLongPress: stopButtonHandler,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const BBAppBar.hideBackArrow(),
        body: Container(
            child: Stack(children: [
          BBMap(controller: mapController),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(timerValue),
                        const Text("420km"),
                        const Text("42.0"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        "69km/h",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Text(currentPosition),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomRoundButton.small(
                        icon: const Icon(
                          Icons.location_pin,
                          size: 25,
                        ),
                        onPressed: resetMapPosition,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: isRideActive == true
                        ? activeRideButtons
                        : inactiveRideButtons,
                  ),
                ),
              ],
            ),
          ),
        ])),
      ),
    );
  }
}
