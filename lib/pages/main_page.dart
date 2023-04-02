import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/components/drawer/bb_drawer.dart';
import 'package:bike_buddy/pages/ride/ride_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const String routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BBAppBar(),
      drawer: const BBDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/map1.png"),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: const Alignment(.0, .6),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 111, 111, 111),
                    ),
                  ),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, RidePage.routeName),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                  child: Text(
                    AppLocalizations.of(context)!.start_training,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 40, 40, 40),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
