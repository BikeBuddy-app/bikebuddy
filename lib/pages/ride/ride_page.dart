import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/components/custom_round_button.dart';
import 'package:bike_buddy/components/map/bb_map.dart';
import 'package:bike_buddy/constants/default_values.dart' as default_values;
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:bike_buddy/pages/ride/map_drawer.dart';
import 'package:bike_buddy/pages/ride_details_page.dart';
import 'package:bike_buddy/services/locator.dart';
import 'package:bike_buddy/services/timer.dart';
import 'package:bike_buddy/utils/settings_manager.dart';
import 'package:bike_buddy/utils/telemetry.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart' as provider;

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
  late final MapDrawer mapDrawer;

  late final int riderWeight;

  double currentDistance = 0.0;
  double burnedCalories = 0.0;
  double currentSpeed = 0.0;

  double maxCurrentSpeed = 0.0;
  Box<dynamic> rideRecordsBox = Hive.box("ride_records");
  RideRecord rideRecord = RideRecord();

  @override
  void initState() {
    initializeTimer(); //todo sprobowac inicializowac jako constructor initializer list??
    initializeLocator();
    initializeMapDrawer();
    initializeRiderInfo();
    super.initState();
  }

  void initializeMapDrawer() {
    mapDrawer = MapDrawer(currentPosition);
  }

  void savePositionRecord() {
    rideRecord.addRoutePoint(PositionRecord(currentTime, currentPosition));
  }

  void saveCurrentRide() {
    rideRecord.setTime(currentTime);
    rideRecord.setMaxSpeed(maxCurrentSpeed);
    rideRecordsBox.add(rideRecord);
  }

  void initializeRiderInfo() {
    final settings = context.read<SettingsManager>();
    riderWeight = settings.riderWeight;
  }

  void initializeLocator() {
    locator = Locator(
      (newPosition) => setState(() {
        //todo nie uzywac setState w ten sposob, setstate tylko do zmiany stanu
        currentPosition = newPosition;
        mapDrawer.draw(rideRecord);
        if (isRideActive == true) {
          savePositionRecord();
          currentDistance = calculateDistance(rideRecord.route) / 1000;
          burnedCalories =
              calculateBurnedCalories(currentTime, riderWeight);
        }
        currentSpeed =
            double.parse((currentPosition.speed * 3.6).toStringAsFixed(1));
        if (currentSpeed > maxCurrentSpeed) maxCurrentSpeed = currentSpeed;
      }),
    );
    locator.start();
  }

  void initializeTimer() {
    timer = Timer((currentTime) => setState(() {
          this.currentTime = currentTime;
        }));
    timer.start();
  }

  void resumeButtonHandler() {
    setState(() {
      isRideActive = true;
    });
    timer.resume();
    mapDrawer.resume();
  }

  void pauseButtonHandler() {
    setState(() {
      isRideActive = false;
    });
    timer.pause();
    mapDrawer.pause(rideRecord);
  }

  void stopButtonHandler() {
    locator.stop();
    timer.stop();
    saveCurrentRide();
    print(mapDrawer.toString());
    Navigator.pushReplacementNamed(context, RideDetailsPage.routeName,
        arguments: {
          'trip': rideRecord,
          'maxCurrentSpeed': maxCurrentSpeed,
          'mapDrawer': mapDrawer,
        });
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
        body: Stack(
          children: [
            BBMap(controller: mapDrawer.mapController),
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
                          Text("$burnedCalories kcal"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          "$currentSpeed km/h",
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
                          onPressed:
                              () {}, //todo jezeli bedzie przesuwanie mapy palcem to zaimplementowac, jak nie - wywalic przycisk
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
          ],
        ),
      ),
    );
  }
}
