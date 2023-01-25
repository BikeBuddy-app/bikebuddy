import 'package:flutter/material.dart';

import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  static const routeName = '/user';

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  //temp variables to be replace with data from a provider
  final username = "Username";
  final distance = 420;
  final calories = 7;
  final time = const Duration(hours: 2, minutes: 10, seconds: 37);
  final streak = 9;
  final maxDistance = 200;

  bool showWeekly = false;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: const BBAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.7,
                  child: Container(
                    color: Colors.grey.shade500,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Theme.of(context).canvasColor,
                      ),
                      const CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(
                          "./images/profile_picture_placeholder.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                username,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: XPBar(),
          ),
          Expanded(
            flex: 6,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                border: Border.all(color: Colors.grey.shade700, width: 5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.8,
                          child: Text(
                            localization.u_statistics,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Switch(
                          activeColor: Colors.deepPurple,
                          activeTrackColor: Colors.deepPurple.shade300,
                          inactiveThumbColor: Colors.blueGrey.shade600,
                          inactiveTrackColor: Colors.grey.shade500,
                          value: showWeekly,
                          onChanged: (value) => setState(() {
                            showWeekly = value;
                          }),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          StatsTile(
                            icon: const Icon(Icons.pedal_bike),
                            title: localization.u_distance,
                            value: "${distance}km",
                          ),
                          StatsTile(
                            icon: const Icon(Icons.local_fire_department),
                            title: localization.u_calories,
                            value: "${calories}kcal",
                          ),
                          StatsTile(
                            icon: const Icon(Icons.timer),
                            title: localization.u_time,
                            value: time.toString().split('.').first.padLeft(8, "0"),
                          ),
                          StatsTile(
                            icon: const Icon(Icons.calendar_month),
                            title: localization.u_streak,
                            value: streak.toString(),
                          ),
                          StatsTile(
                            icon: const Icon(Icons.emoji_events),
                            title: localization.u_max_distance,
                            value: "${maxDistance}km",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatsTile extends StatelessWidget {
  const StatsTile({required this.icon, required this.title, required this.value, super.key});

  final Icon icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: icon,
        textColor: Colors.black,
        iconColor: Colors.black,
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 20),
        ),
        title: Text(title),
      ),
    );
  }
}

class XPBar extends StatelessWidget {
  const XPBar({super.key});

  final level = 69;
  final totalXp = 37;
  final xp = 21;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 15,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: xp / totalXp,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text("Lv $level"),
          ],
        ),
        Text("$xp/$totalXp XP"),
      ],
    );
  }
}
