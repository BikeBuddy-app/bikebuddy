import 'package:bike_buddy/components/bike_buddy_bar.dart';
import 'package:bike_buddy/pages/ride_page.dart';
import 'package:bike_buddy/pages/settings/settings_page.dart';
import 'package:bike_buddy/pages/trip_history.dart';
import 'package:flutter/material.dart';
import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/components/bb_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BBAppBar(context),
        drawer: BBDrawer(context),
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/map1.png"), fit: BoxFit.cover)),
          ),
          Positioned.fill(
              child: Align(
                  alignment: const Alignment(.0, .6),
                  child: TextButton(
                    onPressed: () => {Navigator.pushNamed(context, "/ride")},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                    side: const BorderSide(
                                        color: Color.fromARGB(
                                            255, 111, 111, 111))))),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: Text(
                            AppLocalizations.of(context)!.start_training,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 40, 40, 40)))),
                  )))
        ]));
  }
}
