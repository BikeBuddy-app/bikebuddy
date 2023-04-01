import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/components/custom_round_button.dart';
import 'package:bike_buddy/services/timer.dart';
import 'package:bike_buddy/pages/ride_details_page.dart';
import 'package:flutter/material.dart';

import '../../services/location.dart';
import '../../services/locator.dart';

class RidePage extends StatefulWidget {
  const RidePage({super.key});

  static const String routeName = '/ride';

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  bool isRideActive = true;

  late Timer timer;
  late Locator location;

  String timerValue = "00:00:00";
  String currentLocation = "GPS does not work";

  @override
  void initState() {
    initializeTimer();
    initializeLocator();
    super.initState();
  }

  void initializeLocator() {
    location = Locator(
      (Location currentLocation) => setState(() {
        this.currentLocation = currentLocation.asString();
      }),
    );
    location.start();
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
  }

  void pauseButtonHandler() {
    setState(() {
      isRideActive = false;
    });
    timer.pause();
  }

  void stopButtonHandler() {
    location.stop();
    timer.stop();
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/map.png"),
            ),
          ),
          child: Center(
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
                  child: Text(currentLocation),
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
                        onPressed: () {},
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
        ),
      ),
    );
  }
}
