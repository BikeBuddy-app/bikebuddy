import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:bike_buddy/utils/settings_manager.dart';
import 'package:bike_buddy/utils/telemetry.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

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
  late String username = "Username";
  late double distance = 0;
  late double calories = 0;
  late Duration time;
  late int streak = 0;
  late double maxDistance = 0;

  bool showWeekly = false;

  void loadStats() {
    final Box<RideRecord> box = Hive.box('ride_records');
    final settings = context.read<SettingsManager>();
    final records = showWeekly ? box.values.where((e) => e.fromThisWeek) : box.values;
    distance = calcTotalDistance(records);
    calories = calcTotalCalories(records, settings.riderWeight);
    time = calcTotalRideDuration(records);
    streak = calcStreak(records);
    maxDistance = calcMaxDistance(records);
  }

  @override
  void initState() {
    loadStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                  child: Container(color: Theme.of(context).colorScheme.primaryContainer),
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
                style: textTheme.headlineSmall,
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
                color: Theme.of(context).colorScheme.primaryContainer,
                border: Border.all(color: Theme.of(context).colorScheme.onTertiary, width: 5),
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
                            style: textTheme.titleMedium,
                          ),
                        ),
                        Switch(
                          value: showWeekly,
                          onChanged: (value) => setState(() {
                            showWeekly = value;
                            loadStats();
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
                            value: "${distance / 1000}km",
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
                            value: "${maxDistance / 1000}km",
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: icon,
        //textColor: Colors.black,
        //iconColor: Colors.black,
        trailing: Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
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
    final colorScheme = Theme.of(context).colorScheme;
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
                      border: Border.all(color: colorScheme.onTertiary, width: 2),
                      color: colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: xp / totalXp,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.brightness == Brightness.light
                            ? colorScheme.primary
                            : colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              "Lv $level",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Text(
          "$xp/$totalXp XP",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
