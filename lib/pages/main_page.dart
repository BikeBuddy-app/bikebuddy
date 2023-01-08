import 'package:bike_buddy/components/bike_buddy_bar.dart';
import 'package:bike_buddy/pages/ride_page.dart';
import 'package:bike_buddy/pages/settings/settings_page.dart';
import 'package:bike_buddy/pages/trip_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var translations = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.red,
                child: Center(child: Text(translations!.search)),
              ),
            ),
            Expanded(
              flex: 12,
              child: Image.asset("images/map.png"),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context, RidePage.routeName),
                },
                child: Column(children: [
                  const Icon(
                    IconData(0xe1d2, fontFamily: 'MaterialIcons'),
                  ),
                  Text(translations.start_training),
                ]),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {}, child: Text(translations.m_path)),
                    TextButton(
                        onPressed: () => {
                              Navigator.pushNamed(context, TripHistoryPage.routeName),
                            },
                        child: Text(translations.m_history)),
                    TextButton(
                        onPressed: () {},
                        child: Text(translations.m_achievements)),
                    TextButton(
                        onPressed: () => {
                              Navigator.pushNamed(
                                  context, SettingsPage.routeName),
                            },
                        child: Text(translations.m_settings))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
