import 'dart:math';

import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/components/custom_round_button.dart';
import 'package:bike_buddy/components/map/bb_map.dart';
import 'package:bike_buddy/constants/default_values.dart' as default_values;
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:bike_buddy/pages/ride_details_page.dart';
import 'package:bike_buddy/services/locator.dart';
import 'package:bike_buddy/services/timer.dart';
import 'package:bike_buddy/utils/position_helper.dart';
import 'package:bike_buddy/utils/telemetry.dart';

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
  Duration currentTime = Duration.zero;
  Position currentPosition = default_values.position;

  late final Timer timer;
  late final Locator locator;
  late final MapController mapController;

  double currentDistance = 0.0;

  var rideRecordsBox = Hive.box("ride_records");
  var rideRecord = RideRecord();

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
      initPosition: getGeoPoint(currentPosition),
    );
  }

  void savePositionRecord() {
    rideRecord.addRoutePoint(PositionRecord(currentTime, currentPosition));
  }

  void saveCurrentRide() {
    rideRecord.setTime(currentTime);
    rideRecordsBox.add(rideRecord);
  }

  void initializeLocator() {
    locator = Locator(
      (newPosition) => setState(() {
        currentPosition = newPosition;
        savePositionRecord();
      }),
    );
    locator.start();
  }

  void initializeTimer() {
    timer = Timer(
      (currentTime) => setState(() {
        this.currentTime = currentTime;
      })
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

    if (rideRecord.route.isEmpty) {
      return;
    }
    var firstPos = rideRecord.route[0].position;

    var minLat = firstPos.latitude;
    var maxLat = firstPos.latitude;
    var minLon = firstPos.longitude;
    var maxLon = firstPos.longitude;

    for (final routeRecord in rideRecord.route) {
      minLat = min(minLat, routeRecord.position.latitude);
      maxLat = max(maxLat, routeRecord.position.latitude);
      minLon = min(minLon, routeRecord.position.longitude);
      maxLon = max(maxLon, routeRecord.position.longitude);
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
    setState(() {
      currentDistance = calculateDistance(rideRecord.route);    // just to test distance calculation
    });
  }

  void stopButtonHandler() {
    locator.stop();
    timer.stop();
    saveCurrentRide();

    Navigator.pushReplacementNamed(context, RideDetailsPage.routeName, arguments: {'trip': rideRecord});
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
                        Text(currentTime.toString()),
                        Text("$currentDistance km"),
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
                  child: Text(currentPosition.toString()),
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
