import 'package:bike_buddy/components/speed_display.dart';
import 'package:bike_buddy/components/value_display.dart';
import 'package:bike_buddy/components/countdown.dart';
import 'package:bike_buddy/extensions/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart' as provider;

import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/components/custom_round_button.dart';
import 'package:bike_buddy/components/map/bb_map.dart';
import 'package:bike_buddy/constants/default_values.dart' as default_values;
import 'package:bike_buddy/extensions/position_extension.dart';
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:bike_buddy/pages/ride/map_drawer.dart';
import 'package:bike_buddy/pages/ride_details_page.dart';
import 'package:bike_buddy/services/buddy_drawer.dart';
import 'package:bike_buddy/services/locator.dart';
import 'package:bike_buddy/services/timer.dart';
import 'package:bike_buddy/utils/settings_manager.dart';
import 'package:bike_buddy/utils/telemetry.dart';

class RidePage extends StatefulWidget {
  const RidePage({super.key});

  static const String routeName = '/ride';

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> with TickerProviderStateMixin {
  bool isRideActive = true;
  bool isCountdownActive = true;
  bool isMapReady = true;
  Duration currentTime = Duration.zero;
  Position currentPosition = default_values.position;

  late final BBMap map;
  late final Timer timer;
  late final Locator locator;
  late final MapDrawer mapDrawer;
  late final AnimationController _countdownController;
  late final RideRecord buddyRideRecord;
  BuddyDrawer? buddyDrawer;

  late final int riderWeight;

  double currentDistance = 0.0;
  double burnedCalories = 0.0;
  double currentSpeed = 0.0;
  double maxCurrentSpeed = 0.0;
  final Box<RideRecord> rideRecordsBox = Hive.box("ride_records");
  RideRecord rideRecord = RideRecord();

  @override
  void initState() {
    initializeTimer(); //todo sprobowac inicializowac jako constructor initializer list??
    initializeLocator().then((_) => initializeCurrentLocation());
    initializeMap();
    initializeRiderInfo();
    initializeCountdown();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeBuddyIfEnabled();
    startTimers();
  }

  void initializeBuddyIfEnabled() {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final rideRecord = arguments?['trackedRide'] as RideRecord?;
    if (rideRecord == null) return;
    buddyRideRecord = rideRecord;

    // wait for map and controllers to initialize
    Future.delayed(const Duration(milliseconds: 500), () {
      buddyDrawer = BuddyDrawer(buddyRideRecord, mapDrawer);
      buddyDrawer?.drawRoute();

      //mapDrawer.drawBuddyRoad(buddyRideRecord);
      //buddyDrawer?.start();
    });
  }

  void startTimers() {
    Future.delayed(const Duration(milliseconds: 500), () {
      timer.start();
      buddyDrawer?.start();
    });
  }

  void initializeMap() {
    mapDrawer = MapDrawer();
  }

  void savePositionRecord(Position position) {
    rideRecord.addRoutePoint(PositionRecord(currentTime, position));
  }

  void saveCurrentRide() {
    rideRecord.time = currentTime;
    rideRecord.maxSpeed = maxCurrentSpeed;
    rideRecordsBox.add(rideRecord);
  }

  void initializeRiderInfo() {
    final settings = context.read<SettingsManager>();
    riderWeight = settings.riderWeight;
  }

  Future<void> initializeLocator() async {
    locator = Locator((newPosition) {
      updatePosition(newPosition);
      timer.registerMove();
    });
    await locator.start();
  }

  void initializeTimer() {
    timer = Timer(
      changeCallback: (currentTime) => setState(() {
        this.currentTime = currentTime;
      }),
      onNotMoving: () => setState(() {
        currentSpeed = 0;
      }),
    );
  }

  void initializeCountdown() {
    _countdownController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..addListener(
        () => setState(() {}),
      )
      ..reverse(from: 1.0).whenComplete(
        () => setState(() => isCountdownActive = false),
      );
  }

  void initializeCurrentLocation() async {
    final loc = await locator.currentPosition;
    setState(() {
      currentPosition = loc;
    });
    mapDrawer.mapController.goToLocation(loc.toGeoPoint());
    updatePosition(loc);
  }

  void updatePosition(Position pos) {
    setState(() {
      //todo nie uzywac setState w ten sposob, setstate tylko do zmiany stanu
      currentPosition = pos;
      if (isRideActive == true) {
        savePositionRecord(pos);
        currentDistance = calculateDistance(rideRecord.asSegments()) / 1000;
        burnedCalories = calculateBurnedCalories(currentTime, riderWeight);
      }
      currentSpeed = double.parse((currentPosition.speed * 3.6).toStringAsFixed(1));
      if (currentSpeed > maxCurrentSpeed) maxCurrentSpeed = currentSpeed;
      mapDrawer.draw(pos);
    });
  }

  void resumeButtonHandler() {
    setState(() {
      isRideActive = true;
    });
    timer.resume();
    buddyDrawer?.resume();
    mapDrawer.resume();
    savePositionRecord(currentPosition);
  }

  void pauseButtonHandler() {
    setState(() {
      isRideActive = false;
    });
    timer.pause();
    buddyDrawer?.pause();
    rideRecord.addPause();
    mapDrawer.pause(rideRecord);
  }

  void stopButtonHandler() {
    locator.stop();
    timer.stop();
    buddyDrawer?.stop();
    saveCurrentRide();
    Navigator.pushReplacementNamed(
      context,
      RideDetailsPage.routeName,
      arguments: {
        'trip': rideRecord,
        'maxCurrentSpeed': maxCurrentSpeed,
        'mapDrawer': mapDrawer,
      },
    );
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
            BBMap(
              controller: mapDrawer.mapController,
              onLoaded: (isReady) {
                if (isReady) {
                  setState(() {
                    isMapReady = true;
                  });
                }
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueDisplay(
                      width: 100,
                      value: currentTime.toString(),
                    ),
                    ValueDisplay(
                      width: 100,
                      value: "${currentDistance.toPrecision(2)} km",
                    ),
                    ValueDisplay(
                      width: 125,
                      value: "${burnedCalories.toPrecision(1)} kcal",
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: isRideActive == true ? activeRideButtons : inactiveRideButtons,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SpeedDisplay(
                  width: 100,
                  value: currentSpeed,
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 200,
              child: CustomRoundButton.small(
                icon: const Icon(
                  Icons.location_pin,
                  size: 25,
                ),
                onPressed: () {
                  buddyDrawer?.zoomOutToShowWholeRoute();
                },
              ),
            ),
            IgnorePointer(
              ignoring: !isCountdownActive && isMapReady,
              child: AnimatedOpacity(
                opacity: isCountdownActive || !isMapReady ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.background,
                  child: Countdown(controller: _countdownController),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
