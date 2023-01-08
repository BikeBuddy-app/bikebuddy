import 'dart:async';
import 'package:bike_buddy/pages/ride_details_page.dart';
import 'package:flutter/material.dart';
import 'package:bike_buddy/components/bb_appbar.dart';

import '../components/CustomRoundButton.dart';

class RidePage extends StatefulWidget {
  const RidePage({super.key});

  static const String routeName = '/ride';

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  bool isRideActive = true;

  Timer? countdownTimer;
  Duration trainingDuration = const Duration(seconds: 0);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => increaseTimer());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => trainingDuration = Duration(seconds: 0));
  }

  void increaseTimer() {
    const increaseSecondsBy = 1;
    setState(() {
      final seconds = trainingDuration.inSeconds + increaseSecondsBy;
      trainingDuration = Duration(seconds: seconds);
    });
  }

  void resumeButtonHandler() {
    setState(() {
      isRideActive = true;
      startTimer();
    });
  }

  void pauseButtonHandler() {
    setState(() {
      isRideActive = false;
      stopTimer();
    });
  }

  late final List<Widget> activeRideButtons = [
    CustomRoundButton.large(
        onPressed: () {
          pauseButtonHandler();
        },
        icon: const Icon(
          Icons.pause,
          size: 60,
        )),
  ];

  late final List<Widget> inactiveRideButtons = [
    CustomRoundButton.large(
        onPressed: () => resumeButtonHandler(),
        icon: const Icon(
          Icons.play_arrow,
          size: 60,
        ),
        backgroundColor: Colors.green),
    const SizedBox(
      width: 10,
    ),
    CustomRoundButton.medium(
      onPressed: () {},
      icon: const Icon(
        Icons.stop,
        size: 48,
      ),
      backgroundColor: Colors.redAccent,
      onLongPress: () {
        Navigator.pushReplacementNamed(context, RideDetailsPage.routeName);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final String hours = strDigits(trainingDuration.inHours);
    final String minutes = strDigits(trainingDuration.inMinutes.remainder(60));
    final String seconds = strDigits(trainingDuration.inSeconds.remainder(60));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: BBAppBar.hideBackArrow(context),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/map.png"),
            fit: BoxFit.cover,
          )),
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
                        Container(
                          child: Text("$hours:$minutes:$seconds"),
                        ),
                        Container(
                          child: const Text("420km"),
                        ),
                        Container(
                          child: const Text("42.0"),
                        ),
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
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomRoundButton.small(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.location_pin,
                            size: 25,
                          ))
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
